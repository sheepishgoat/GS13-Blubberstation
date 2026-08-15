/obj/item/portable_transmog
	name = "Handheld Transmogrifier Soulcatcher"
	desc = "a modified version of the attachable soulcatcher designed to transform others into objects."
	icon_state = "transmog"
	icon = 'modular_gs/icons/obj/device.dmi'
	/// What items do we want to prevent the viewer from attaching this to? (Copy and pasted from the attachable soulcatcher)
	var/list/blacklisted_items = list(
		/obj/item/organ,
		/obj/item/mmi,
		/obj/item/pai_card,
		/obj/item/aicard,
		/obj/item/card,
		/obj/item/radio,
		/obj/item/disk/nuclear, // Woah there
		/obj/item/storage,
		/obj/item/portable_transmog,
	)
	/// What is the typepath of the soulcatcher component that we want to attach?
	var/soulcatcher_typepath = /datum/component/carrier/soulcatcher/attachable/transformation

/obj/item/portable_transmog/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isitem(interacting_with) || is_type_in_list(interacting_with, blacklisted_items))
		balloon_alert(user, "incompatible!")
		return NONE

	if(interacting_with.GetComponent(/datum/component/carrier/soulcatcher))
		balloon_alert(user, "already attached!")
		return ITEM_INTERACT_BLOCKING

	interacting_with.AddComponent(soulcatcher_typepath)
	playsound(interacting_with.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)
	qdel(src)

/datum/component/carrier/soulcatcher/attachable/transformation
	/// Will this item TF people?
	var/tf_mode_enabled = FALSE

/datum/component/carrier/soulcatcher/attachable/transformation/on_examine(datum/source, mob/user, list/examine_text)
	examine_text += span_cyan("[source] has a soulcatcher attached to it, <b>Ctrl+Shift+Click</b> to use it.")
	examine_text += span_abductor("This object will [tf_mode_enabled ? "" : "not"] attempt to transform people. <b>Alt+Right-Click</b> to toggle this.")

/datum/component/carrier/soulcatcher/attachable/transformation/Initialize()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(try_to_capture))
	RegisterSignal(parent, COMSIG_CLICK_ALT_SECONDARY, PROC_REF(toggle_tf))

/// Toggles if the parent object will transform people or not
/datum/component/carrier/soulcatcher/attachable/transformation/proc/toggle_tf(datum/source, mob/user)
	SIGNAL_HANDLER
	tf_mode_enabled = !tf_mode_enabled
	if(user)
		to_chat(user, span_notice("Transformation [tf_mode_enabled ? "enabled" : "disabled"]"))

/// Try to capture someone to transform them.
/datum/component/carrier/soulcatcher/attachable/transformation/proc/try_to_capture(obj/item/source, mob/living/target_mob, mob/living/user)
	SIGNAL_HANDLER
	if(!target_mob || !istype(target_mob) || !tf_mode_enabled)
		return

	if(!istype(parent))
		return // what

	. = COMPONENT_CANCEL_ATTACK_CHAIN // No hurting other cultists.

	/*
	if(!parent_item.Adjacent(target_mob))
		to_chat(user, span_warning("The [parent] isn't close enough to [target_mob]"))
		return
	*/

	if(!target_mob?.mind)
		to_chat(user, span_warning("You are unable to transform someone without a mind."))
		return

	INVOKE_ASYNC(src, PROC_REF(perform_the_capture), source, target_mob, user) // Split the part of this that requires the game to sleep into a seperate proc so that this can compile
	return

/datum/component/carrier/soulcatcher/attachable/transformation/proc/perform_the_capture(obj/item/source, mob/living/target_mob, mob/living/user)
	var/obj/item/parent_item = parent
	var/datum/carrier_room/target_room = tgui_input_list(user, "Choose a room to send [target_mob]'s soul to.", name, carrier_rooms, timeout = 30 SECONDS)
	if(!target_room)
		return

	SEND_SOUND(target_mob, 'sound/announcer/notice/notice2.ogg')
	window_flash(target_mob.client)

	if((tgui_alert(target_mob, "Do you wish to be transformed?", name, list("Yes", "No"), 30 SECONDS, FALSE) != "Yes") || (tgui_alert(target_mob, "Are you sure about this?", name, list("Yes", "No"), 30 SECONDS, FALSE) != "Yes"))
		to_chat(user, span_warning("[target_mob] doesn't seem to want to be transformed."))
		return

	/*
	if(!parent_item.Adjacent(target_mob))
		to_chat(user, span_warning("The [parent] isn't close enough to [target_mob]"))
		return
	*/

	if(parent_item in target_mob.contents) //If holding and TFing yourself into it, drop it.
		var/turf/current_tile = get_turf(parent_item)
		parent_item.forceMove(current_tile)

	if(!target_mob?.mind)
		return

	if(!target_room.add_soul_from_mind(target_mob.mind, FALSE))
		return

	scan_body(target_mob, user)

	target_mob.forceMove(parent)
	ADD_TRAIT(target_mob, TRAIT_STASIS, TRAIT_CARRIER)
	ADD_TRAIT(target_mob, TRAIT_TRANSFORMED, TRAIT_CARRIER)
	ADD_TRAIT(target_mob, TRAIT_NOBREATH, TRAIT_CARRIER)

	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	parent_item.visible_message(span_notice("[src] beeps: [target_mob]'s transformation is complete."))

	var/turf/source_turf = get_turf(user)
	log_admin("[key_name(user)] used [src] to put [key_name(target_mob)]'s mind into a soulcatcher while they were still alive at [AREACOORD(source_turf)]")


/datum/component/carrier/soulcatcher/attachable/transformation/proc/untransform_mob(mob/living/target_mob)
	var/obj/item/parent_item = parent
	if(!istype(parent_item) || !(target_mob in parent_item.contents) || !HAS_TRAIT(target_mob, TRAIT_TRANSFORMED))
		return FALSE

	REMOVE_TRAIT(target_mob, TRAIT_STASIS, TRAIT_CARRIER)
	REMOVE_TRAIT(target_mob, TRAIT_TRANSFORMED, TRAIT_CARRIER)
	REMOVE_TRAIT(target_mob, TRAIT_NOBREATH, TRAIT_CARRIER)

	var/turf/current_tile = get_turf(parent_item)
	target_mob.forceMove(current_tile)

	return TRUE

/datum/component/carrier/soulcatcher/attachable/transformation/Destroy(force)
	UnregisterSignal(parent, COMSIG_ITEM_ATTACK)
	UnregisterSignal(parent, COMSIG_CLICK_ALT_SECONDARY)
	return ..()

/datum/component/carrier/soulcatcher/attachable/transformation/remove_self()
	if(removable)
		var/obj/item/parent_item = parent
		var/turf/drop_turf = get_turf(parent_item)
		new /obj/item/portable_transmog (drop_turf)

	qdel(src)


/mob/living/soulcatcher_soul/proc/remove_body_from_carrier(mob/living/original_body)
	var/datum/component/carrier_user/soul_component = GetComponent(/datum/component/carrier_user)
	if(!soul_component?.current_room || !istype(original_body))
		return FALSE // involuntary perma-tf, have fun nerd >:3

	var/datum/carrier_room/room = soul_component.current_room.resolve()
	if(!istype(room))
		return FALSE

	var/datum/component/carrier/soulcatcher/attachable/transformation/parent_carrier = room.master_carrier.resolve()
	if(!istype(parent_carrier))
		return FALSE

	parent_carrier.untransform_mob(original_body)


