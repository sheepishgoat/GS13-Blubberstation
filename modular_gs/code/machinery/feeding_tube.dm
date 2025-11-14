/obj/machinery/iv_drip
	/// What is the name of the thing being attached to the mob?
	var/attachment_point = "needle"


/obj/machinery/iv_drip/feeding_tube
	name = "\improper Feeding tube"
	desc = "Originally meant to automatically feed cattle and farm animals, this model was repurposed for more... personal usage. Comes with a nifty portable blender"
	icon = 'modular_gs/icons/obj/feeding_tube.dmi'
	base_icon_state = "feeding_tube"
	icon_state = "feeding_tube"
	attachment_point = "tube"
	inject_only = TRUE
	alert_type = /atom/movable/screen/alert/tube_connected

	/// What blender is currently in here?
	var/obj/item/portable_blender/our_blender
	/// What is the path of the blender we want to spawn with?
	var/default_blender_path = /obj/item/portable_blender


/obj/machinery/iv_drip/feeding_tube/Initialize(mapload)
	. = ..()
	if(ispath(default_blender_path))
		new default_blender_path(src)

/obj/machinery/iv_drip/feeding_tube/eject_beaker()
	if(!isliving(usr))
		to_chat(usr, span_warning("You can't do that!"))
		return
	if(!usr.can_perform_action(src))
		return
	if(usr.incapacitated)
		return
	if(reagent_container || our_blender)
		if(attachment)
			visible_message(span_warning("[attachment?.attached_to] is detached from [src]."))
			detach_iv()

		if(istype(our_blender))
			our_blender.forceMove(drop_location())
			our_blender = null
		else
			reagent_container.forceMove(drop_location())

		reagent_container = null
		update_appearance(UPDATE_ICON)

/obj/machinery/iv_drip/feeding_tube/proc/insert_blender(obj/item/portable_blender/new_blender)
	if(reagent_container)
		eject_beaker() //Pop the old beaker out.

	if(!istype(new_blender) || !new_blender?.loaded_reagent_container)
		return FALSE

	our_blender = new_blender
	reagent_container = our_blender.loaded_reagent_container

	update_appearance(UPDATE_ICON)
	return TRUE


/obj/machinery/iv_drip/feeding_tube/toggle_mode()
	return FALSE

/obj/machinery/iv_drip/feeding_tube/process(seconds_per_tick)
	if(!attachment)
		return PROCESS_KILL

	var/atom/attached_to = attachment.attached_to

	if(!(get_dist(src, attached_to) <= 1 && isturf(attached_to.loc)))
		visible_message(span_warning("[attached_to] is detached from [src]."))
		detach_iv()
		return PROCESS_KILL

	var/datum/reagents/drip_reagents = get_reagents()
	if(!drip_reagents)
		return PROCESS_KILL

	var/mob/living/carbon/attached_carbon = attached_to
	if(!istype(attached_carbon))
		return FALSE

	if(!transfer_rate)
		return

	var/obj/item/organ/stomach/target_stomach = attached_carbon?.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(target_stomach))
		return FALSE

	// Give reagents
	if(mode)
		if(drip_reagents.total_volume)
			drip_reagents.trans_to(target_stomach.reagents, transfer_rate * seconds_per_tick, show_message = FALSE) //make reagents reacts, but don't spam messages
			update_appearance(UPDATE_ICON)

/obj/machinery/iv_drip/feeding_tube/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/obj/item/food/inserted_food = tool
	if(istype(inserted_food) && our_blender)
		our_blender.insert_food(inserted_food, user, TRUE)
		update_appearance(UPDATE_ICON)
		return ITEM_INTERACT_BLOCKING

	var/obj/item/portable_blender/new_blender = tool
	if(istype(new_blender))
		if(our_blender)
			to_chat(user, span_warning("There is already a blender inserted!"))
		else
			if(user.transferItemToLoc(new_blender, src))
				insert_blender(new_blender)
				return ITEM_INTERACT_BLOCKING

	return ..()

//it sure is a solution.
/obj/machinery/iv_drip/feeding_tube/toggle_mode()
	return FALSE

/atom/movable/screen/alert/tube_connected
	name = "Feeding Tube Connected"
	desc = "You have a feeding tube connected to you!"
	icon_state = "food_buff_2" //Placeholder for now

