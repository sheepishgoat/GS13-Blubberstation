/datum/quirk/helplessness/hardcore_fatty
	name = "Hardcore Fatty"
	desc = "THIS QUIRK WILL BYPASS MANY PREFERENCES, PICK THIS WITH CAUTION!!! Drastically lowers WG & WL rates, applies most of the helplessness quirks, enables most of the weight gain prefs (excluding bursting), and makes being at higher weights more punishing. Having this quirk will contribute towards a leaderboard score along with other perks."
	icon = "fa-weight-hanging"
	medical_record_text = "Patients seems to gain and lose weight slower."
	value =  -38 // Lots of value because you are locked out of other quirks.
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN
	erp_quirk = FALSE
	mob_trait = TRAIT_HARDCORE_FATTY
	// What traits do we want to apply to someone with the hardcore fatty quirk?
	var/list/hardcore_fatty_traits = list(
		TRAIT_HELPLESS_IMMOBILITY,
		TRAIT_HELPLESS_CLUMSY,
		TRAIT_HELPLESS_BIG_CHEEKS,
		TRAIT_HELPLESS_IMMOBILE_ARMS,
		TRAIT_HELPLESS_BACKPACKS,
		TRAIT_HELPLESS_BELTS,
		TRAIT_HELPLESS_NO_BUCKLE,
		TRAIT_HELPLESS_CHAIR_DESTROYER,
		TRAIT_HELPLESS_STUCKAGE,
		TRAIT_HELPLESS_THICK_NECK,
		TRAIT_HELPLESS_NEARSIGHTED,
		)

/datum/quirk/helplessness/hardcore_fatty/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	new_holder.add_traits(hardcore_fatty_traits, mob_trait)

/datum/quirk/helplessness/hardcore_fatty/remove_from_current_holder(quirk_transfer)
	if (!quirk_holder)
		CRASH("Attempted to remove quirk from the current holder when it has no current holder.")

	quirk_holder.remove_traits(hardcore_fatty_traits, mob_trait)
	. = ..()

/datum/award/score/hardcore_fatty_total
	name = "Hardcore fatty total shifts completed"
	desc = "You aren't in the room with the food, the food is in the room with you."
	database_id = HARDCORE_RANDOM_SCORE

/datum/award/score/hardcore_fatty_streak
	name = "Hardcore fatty consecutive shifts completed"
	desc = "Either you are really good or really bad at managing your weight."
	database_id = HARDCORE_RANDOM_SCORE
