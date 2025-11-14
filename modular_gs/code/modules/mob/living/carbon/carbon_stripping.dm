/datum/strippable_item/mob_item_slot/belt/get_alternate_actions(atom/source, mob/user)
	. = ..()
	. += get_strippable_alternate_action_bluespace_belt(get_item(source), source)

/datum/strippable_item/mob_item_slot/belt/perform_alternate_action(atom/source, mob/user, action_key)
	..()
	if(action_key in get_strippable_alternate_action_bluespace_belt(get_item(source), source))
		strippable_alternate_action_bluespace_belt(get_item(source), source, user)

/proc/get_strippable_alternate_action_bluespace_belt(obj/item/item, atom/source)
	if (!iscarbon(source))
		return

	if (istype(item, /obj/item/bluespace_belt) && !istype(item, /obj/item/bluespace_belt/primitive))
		return list("bluespace_belt_adjustment")

/proc/strippable_alternate_action_bluespace_belt(obj/item/item, atom/source, mob/user)
	if (!istype(item, /obj/item/bluespace_belt))
		return
	
	if (istype(item, /obj/item/bluespace_belt/primitive))
		return

	var/obj/item/bluespace_belt/bluespace_belt = item

	var/mob/living/carbon/carbon_source = source
	if (!istype(carbon_source))
		return

	carbon_source.visible_message(
		span_danger("[user] tries to access the control panel of [source]'s [item.name]."),
		span_userdanger("[user] tries to access the control panel of your [item.name]."),
		ignored_mobs = user,
	)

	to_chat(user, span_notice("You try to access the control panel of [source]'s [item.name]..."))

	if(!do_after(user, 1 SECONDS, carbon_source))
		return

	bluespace_belt.ui_interact_on_other(user)