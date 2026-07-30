/datum/preference/numeric/helplessness
	abstract_type = /datum/preference/numeric/helplessness
	minimum = 0
	maximum = INFINITY

/datum/preference/numeric/helplessness/create_default_value()
	return 0

/datum/preference/numeric/helplessness/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/helplessness/no_movement
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "no_movement"

/datum/preference/numeric/helplessness/clumsy
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "clumsy"

/datum/preference/numeric/helplessness/nearsighted
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "nearsighted"

/datum/preference/numeric/helplessness/low_fov
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "low_fov"

/datum/preference/numeric/helplessness/hidden_face
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "hidden_face"

/datum/preference/numeric/helplessness/mute
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "mute"

/datum/preference/numeric/helplessness/immobile_arms
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "immobile_arms"

/datum/preference/numeric/helplessness/clothing_jumpsuit
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "clothing_jumpsuit"

/datum/preference/numeric/helplessness/clothing_misc
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "clothing_misc"

/datum/preference/numeric/helplessness/belts
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "belts"

/datum/preference/numeric/helplessness/clothing_back
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "clothing_back"

/datum/preference/numeric/helplessness/no_buckle
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "no_buckle"

/datum/preference/numeric/helplessness/chair_breakage
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "chair_breakage"

/datum/preference/numeric/helplessness/stuckage
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "stuckage"

/datum/preference/numeric/helplessness/stuckage_custom
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "stuckage_custom"
	minimum = 0
	maximum = 100

/datum/preference/numeric/helplessness/no_neck
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "no_neck"

/datum/preference/numeric/helplessness/waddle
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "waddle"

/datum/preference/numeric/helplessness/lisp
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "lisp"
/*
/datum/preference/numeric/helplessness/weak_lungs
	category = HELPLESSNESS_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weak_lungs"
*/
