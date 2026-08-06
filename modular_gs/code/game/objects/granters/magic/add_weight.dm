/obj/item/book/granter/action/spell/gain
	granted_action = /datum/action/cooldown/spell/touch/fatten_up
	action_name = "Gain"
	icon = 'modular_gs/icons/obj/spells/spellbooks.dmi'
	icon_state = "add_weight"
	name = "Book of fattening"
	desc = "A book made out of calorite, holding it alone makes you feel hungry."
	remarks = list(
		"\"Calories are actually energy?\"",
		"\"Concentrate energy on my hand...\"",
		"\"Oh so this is what they mean they can't stop gaining... huh...\"",
		"\"Sounds like feeding someone a pizza might be more effective...\"",
		"\"I feel a bit hungry now.\"",
	)

/obj/item/book/granter/action/spell/gain/recoil(mob/living/user)
	if (!istype(user, /mob/living/carbon))
		return ..()

	var/mob/living/carbon/carbon_user = user

	to_chat(carbon_user, span_warning("The book turns to dust in your hands as you feel a bit heavier"))

	carbon_user.adjust_fatness(100, FATTENING_TYPE_MAGIC)

	qdel(src)

