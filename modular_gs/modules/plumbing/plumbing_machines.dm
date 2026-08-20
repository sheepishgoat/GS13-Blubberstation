///Minimum possible IV drip transfer rate in units per second
#define MIN_IV_TRANSFER_RATE 0
///Maximum possible IV drip transfer rate in units per second
#define MAX_IV_TRANSFER_RATE 5
//Alert shown to mob the IV is still connected
#define ALERT_IV_CONNECTED "iv_connected"

/datum/component/plumbing/automated_iv/gs13/Initialize(start, _ducting_layer, _turn_connects, datum/reagents/custom_receiver)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	var/atom/movable/parent_movable = parent
	if(!parent_movable.reagents && !custom_receiver)
		return COMPONENT_INCOMPATIBLE

	reagents = parent_movable.reagents
	// set_recipient_reagents_holder(custom_receiver ? custom_receiver : parent_movable.reagents)

	ducts = list()
	
	if(start)
		enable()
	if(!istype(parent, /obj/machinery/iv_drip/gs13))
		return COMPONENT_INCOMPATIBLE

	var/obj/machinery/iv_drip/plumbing/drip = parent
	holder = new(drip.reagents.maximum_volume, drip.reagents.flags)
	holder.my_atom = drip

/datum/component/plumbing/automated_iv/gs13/feeder
	demand_connects = SOUTH
	supply_connects = null

/datum/component/plumbing/automated_iv/gs13/feeder/send_request(dir)
	process_request(dir = dir)

/datum/component/plumbing/automated_iv/gs13/milker
	demand_connects = null
	supply_connects = NORTH

/datum/component/plumbing/automated_iv/gs13/milker/can_give(amount, reagent)
	if(amount <= 0)
		return

	var/obj/machinery/iv_drip/plumbing/drip = parent
	if(reagent) //only asked for one type of reagent
		for(var/datum/reagent/contained_reagent as anything in drip.reagents.reagent_list)
			if(contained_reagent.type == reagent)
				return TRUE

	else if(drip.reagents.total_volume) //take whatever
		return TRUE

	return FALSE

/datum/component/plumbing/automated_iv/gs13/milker/transfer_to(datum/component/plumbing/target, amount, reagent, datum/ductnet/net, round_robin = TRUE)
	if(!target || !target.reagents)
		return FALSE

	var/obj/machinery/iv_drip/plumbing/drip = parent
	drip.reagents.trans_to(target.recipient_reagents_holder(), amount, target_id = reagent, methods = INGEST)

/obj/machinery/iv_drip/gs13
	icon = 'modular_gs/icons/obj/plumping.dmi'
	icon_state = "feed"
	base_icon_state = "feed"
	density = TRUE
	use_internal_storage = TRUE
	processing_flags = START_PROCESSING_MANUALLY

/obj/machinery/iv_drip/gs13/ui_interact(mob/user, datum/tgui/ui)
	return

/obj/machinery/iv_drip/gs13/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	transfer_rate = min(MAX_IV_TRANSFER_RATE, transfer_rate + 1)
	balloon_alert(user, "transfer rate [transfer_rate]u")

/obj/machinery/iv_drip/gs13/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	transfer_rate = max(MIN_IV_TRANSFER_RATE, transfer_rate - 1)
	balloon_alert(user, "transfer rate [transfer_rate]u")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/iv_drip/gs13/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	context[SCREENTIP_CONTEXT_LMB] = "Increase flow rate"
	context[SCREENTIP_CONTEXT_RMB] = "Decrease flow rate"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/iv_drip/gs13/mouse_drop_dragged(atom/target, mob/user)
	if(!isliving(user))
		to_chat(user, span_warning("You can't do that!"))
		return

	if(!iscarbon(target))
		to_chat(user, span_warning("This machine only works on humanoids!"))
		return

	if(attachment)
		if(attachment.attached_to == target)
			visible_message(span_warning("[attachment.attached_to] is detached from [src]."))
			detach_iv()
			return

		visible_message(span_warning("[attachment.attached_to] is detached from [src]."))
		detach_iv()
	user.visible_message(span_warning("[user] attaches [src] to [target]."), span_notice("You attach [src] to [target]."))
	attach_iv(target, user)

/obj/machinery/iv_drip/gs13/click_alt(mob/user)
	return FALSE

/obj/machinery/iv_drip/gs13/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	if(isnull(held_item) || held_item.tool_behaviour != TOOL_WRENCH)
		return
	context[SCREENTIP_CONTEXT_LMB] = "[anchored ? "Una" : "A"]nchor"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/iv_drip/gs13/wrench_act(mob/living/user, obj/item/tool)
	if(default_unfasten_wrench(user, tool) != SUCCESSFUL_UNFASTEN)
		return ITEM_INTERACT_BLOCKING
	if(anchored)
		begin_processing()
	else
		end_processing()

	return ITEM_INTERACT_SUCCESS

/obj/machinery/iv_drip/gs13/plunger_act(obj/item/plunger/attacking_plunger, mob/living/user, reinforced)
	user.balloon_alert_to_viewers("furiously plunging...", "plunging [src]...")
	if(!do_after(user, 3 SECONDS, target = src))
		return TRUE
	user.balloon_alert_to_viewers("finished plunging")
	reagents.expose(get_turf(src), TOUCH) //splash on the floor
	reagents.clear_reagents()
	return TRUE

/obj/machinery/iv_drip/gs13/update_icon_state()
	. = ..()
	if(transfer_rate > 0 && attachment)
		icon_state = "[base_icon_state]_on"
	else
		icon_state = "[base_icon_state]"
	return .

/obj/machinery/iv_drip/gs13/attach_iv(atom/target, mob/user)
	if(isliving(target))
		user.visible_message(span_warning("[usr] begins attaching [src] to [target]..."), span_warning("You begin attaching [src] to [target]."))
		if(!do_after(usr, 1 SECONDS, target))
			return

	usr.visible_message(span_warning("[usr] attaches [src] to [target]."), span_notice("You attach [src] to [target]."))
	var/datum/reagents/container = get_reagents()
	log_combat(usr, target, "attached", src, "containing: ([container.get_reagent_log_string()])")
	add_fingerprint(usr)
	if(isliving(target))
		var/mob/living/target_mob = target
		target_mob.throw_alert(ALERT_IV_CONNECTED, alert_type) // GS13 EDIT - Original target_mob.throw_alert(ALERT_IV_CONNECTED, /atom/movable/screen/alert/iv_connected)

	qdel(attachment)
	var/datum/iv_drip_attachment/feeder/feeder_attachment = new(src, target)
	attachment = feeder_attachment

	START_PROCESSING(SSmachines, src)
	update_appearance(UPDATE_ICON)

	SEND_SIGNAL(src, COMSIG_IV_ATTACH, target)

/obj/machinery/iv_drip/gs13/on_deconstruction(disassembled)
	return

/obj/machinery/iv_drip/gs13/plumbing_feeder
	name = "automated feeder"
	desc = "A streamlined pluming machine whose sole function is to take all chemicals inside the connected ducts and feed them to whoever is attached to the other end."
	icon_state = "feed"
	base_icon_state = "feed"

/obj/machinery/iv_drip/gs13/plumbing_feeder/Initialize(mapload, bolt, layer)
	. = ..()
	AddComponent(/datum/component/plumbing/automated_iv/gs13/feeder, bolt, layer)
	// AddComponent(/datum/component/simple_rotation)
	AddElement(/datum/element/simple_rotation)

/obj/machinery/iv_drip/gs13/plumbing_feeder/process(seconds_per_tick)
	if(!attachment)
		return PROCESS_KILL

	var/atom/attached_to = attachment.attached_to
	if(!(get_dist(src, attached_to) <= 3 && isturf(attached_to.loc)))
		if(isliving(attached_to))
			to_chat(attached_to, span_userdanger("The feeding hose drops to the floor."))
		else
			visible_message(span_warning("[attached_to] is detached from [src]."))

		detach_iv()
		return PROCESS_KILL

	var/datum/reagents/drip_reagents = get_reagents()
	if(!drip_reagents)
		return PROCESS_KILL

	if(!transfer_rate)
		return

	if(drip_reagents.total_volume)
		var/mob/living/carbon/carbon = attached_to
		if (istype(carbon))
			var/obj/item/organ/stomach/stomach = carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
			if (istype(stomach))
				attached_to = stomach
		drip_reagents.trans_to(attached_to, transfer_rate * seconds_per_tick, methods = INJECT, show_message = FALSE) //make reagents reacts, but don't spam messages
		update_appearance(UPDATE_ICON)

/obj/machinery/iv_drip/gs13/plumbing_milker
	name = "automated milker"
	desc = "A plumbing machine designed to drain someone of chemicals inside their body, including exposed breasts and genitals."
	icon_state = "milk"
	base_icon_state = "milk"
	mode = IV_TAKING

/obj/machinery/iv_drip/gs13/plumbing_milker/Initialize(mapload, bolt, layer)
	. = ..()
	AddComponent(/datum/component/plumbing/automated_iv/gs13/milker, bolt, layer)
	// AddComponent(/datum/component/simple_rotation)
	AddElement(/datum/element/simple_rotation)

/obj/machinery/iv_drip/gs13/plumbing_milker/get_reagents()
	return reagents

/obj/machinery/iv_drip/gs13/plumbing_milker/process(seconds_per_tick)
	if(!attachment)
		return PROCESS_KILL

	var/atom/attached_to = attachment.attached_to
	if(!(get_dist(src, attached_to) <= 3 && isturf(attached_to.loc)))
		if(isliving(attached_to))
			to_chat(attached_to, span_userdanger("The milking tubes drop to the floor."))
		else
			visible_message(span_warning("[attached_to] is detached from [src]."))
		detach_iv()
		return PROCESS_KILL

	var/datum/reagents/drip_reagents = get_reagents()
	if(!drip_reagents)
		return PROCESS_KILL
	if(!transfer_rate)
		return
	if(!isliving(attached_to))
		return

	var/amount = min(transfer_rate * seconds_per_tick, drip_reagents.maximum_volume - drip_reagents.total_volume)
	if(!amount)
		return

	var/atom/movable/target = use_internal_storage ? src : reagent_container
	var/mob/living/attached_mob = attached_to
	// attached_mob.reagents.trans_to(target, amount)	// idk why we ever took stuff from the bloodstream

	var/obj/item/organ/genital/breasts/breasts = attached_mob.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(breasts && breasts.is_exposed() && breasts.lactates)
		breasts.reagents.trans_to(target, amount)

	var/obj/item/organ/genital/testicles/testes = attached_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/penis/penis = attached_mob.get_organ_slot(ORGAN_SLOT_PENIS)
	if(testes && penis && penis.is_exposed())
		testes.reagents.trans_to(target, amount)

	var/obj/item/organ/genital/vagina = attached_mob.get_organ_slot(ORGAN_SLOT_VAGINA)
	if(vagina && vagina.is_exposed())
		vagina.reagents.trans_to(target, amount)

	update_appearance(UPDATE_ICON)

/datum/iv_drip_attachment/milker/New(obj/machinery/iv_drip/iv_drip, atom/attached_to)
	. = ..()
	beam.override_origin_pixel_x = 11
	beam.override_origin_pixel_y = -3

/datum/iv_drip_attachment/feeder/New(obj/machinery/iv_drip/iv_drip, atom/attached_to)
	. = ..()
	beam.override_origin_pixel_x = 13
	beam.override_origin_pixel_y = -3

#undef IV_TAKING
#undef MIN_IV_TRANSFER_RATE
#undef MAX_IV_TRANSFER_RATE
#undef ALERT_IV_CONNECTED
