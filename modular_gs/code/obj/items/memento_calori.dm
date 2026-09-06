/obj/item/clothing/neck/necklace/memento_mori/calori
	name = "Memento Calori"
	desc = "A mysterious pendant. An inscription on it says: \"Certain obesity tomorrow means certain fitness today.\""
	icon = 'modular_gs/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_gs/icons/mob/clothing/neck.dmi'
	icon_state = "memento_calori"
	worn_icon_state = "memento_calori"
	actions_types = list(/datum/action/item_action/hands_free/memento_mori/calori)
	var/list/past_users = list()

/obj/item/clothing/neck/necklace/memento_mori/calori/sprinkled
	icon_state = "memento_calori_sprinkled"
	worn_icon_state = "memento_calori"

/obj/item/clothing/neck/necklace/memento_mori/calori/memento(mob/living/carbon/human/user)
	to_chat(user, span_warning("You feel your weight being drained by the pendant..."))
	if (!do_after(user, 4 SECONDS, target = user))
		return

	to_chat(user, span_notice("Your weight is now linked to the pendant! You feel like removing it would make your weight skyrocket, and yet you instinctively know that until then, you won't gain weight."))
	user.hider_add(src)
	icon_state = initial(icon_state) + "_active"
	worn_icon_state = initial(worn_icon_state) + "_active"
	active_owner = user
	past_users.Add(user)

/obj/item/clothing/neck/necklace/memento_mori/calori/mori()
	icon_state = initial(icon_state)
	worn_icon_state = initial(worn_icon_state)
	if (!active_owner)
		return
	var/mob/living/carbon/human/stored_owner = active_owner //to avoid infinite looping when dust unequips the pendant
	active_owner = null
	to_chat(stored_owner, span_userdanger("You feel your weight rapidly returning to you!"))
	stored_owner.hider_remove(src)
	stored_owner.adjust_fatness(FATNESS_LEVEL_OBESE, FATTENING_TYPE_MAGIC, TRUE)
	stored_owner.adjust_perma(FATNESS_LEVEL_OBESE, FATTENING_TYPE_MAGIC, TRUE)

/obj/item/clothing/neck/necklace/memento_mori/calori/proc/fat_hide(mob/living/carbon/user)
	var/amount_to_hide = user.fatness_real + user.fatness_perma
	return -(amount_to_hide)

/datum/action/item_action/hands_free/memento_mori/calori
	name = "Memento Calori"
	desc = "Bind your weight to the pendant. Once removed, the effect cannot be applied again."

/datum/action/item_action/hands_free/memento_mori/calori/do_effect(trigger_flags)
	var/obj/item/clothing/neck/necklace/memento_mori/calori/memento = target
	if(memento.active_owner || !ishuman(owner) || memento.past_users.Find(owner))
		to_chat(owner, span_notice("The pendant doesn't react to your prodding..."))
		return FALSE

	memento.memento(owner)
	Remove(memento.active_owner) //Remove the action button, since there's no real use in having it now.
	return TRUE
