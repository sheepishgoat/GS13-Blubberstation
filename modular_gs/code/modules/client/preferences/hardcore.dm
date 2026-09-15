/// Hardcore fatty
/datum/preference/toggle/hardcore_fatty
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "hardcore_fatty"
	default_value = FALSE

/datum/preference/toggle/hardcore_fatty/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!value)
		return
	ADD_TRAIT(target, TRAIT_UNIVERSAL_GAINER, TRAIT_GENERIC)
	/// put code here

/datum/award/score/hardcore_fatty_total
	name = "Hardcore fatty total shifts completed"
	desc = "You aren't in the room with the food, the food is in the room with you."
	database_id = HARDCORE_RANDOM_SCORE


/datum/award/score/hardcore_fatty_streak
	name = "Hardcore fatty consecutive shifts completed"
	desc = "Either you are really good or really bad at managing your weight."
	database_id = HARDCORE_RANDOM_SCORE

