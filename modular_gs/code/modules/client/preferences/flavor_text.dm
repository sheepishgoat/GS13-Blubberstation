/datum/preference/text/ws_text
	category = GS13_EXAMINE_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ws_rounded"
	maximum_value_length = 300 // I feel like this is reasonable?

/datum/preference/text/ws_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_rounded"] = value

/datum/preference/text/ws_text/fat
	savefile_key = "ws_fat"

/datum/preference/text/ws_text/fat/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_fat"] = value

/datum/preference/text/ws_text/very_fat
	savefile_key = "ws_very_fat"

/datum/preference/text/ws_text/very_fat/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_very_fat"] = value

/datum/preference/text/ws_text/obese
	savefile_key = "ws_obese"

/datum/preference/text/ws_text/obese/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_obese"] = value

/datum/preference/text/ws_text/morbidly_obese
	savefile_key = "ws_morbidly_obese"

/datum/preference/text/ws_text/morbidly_obese/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_morbidly_obese"] = value

/datum/preference/text/ws_text/extremely_obese
	savefile_key = "ws_extremely_obese"

/datum/preference/text/ws_text/extremely_obese/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_extremely_obese"] = value

/datum/preference/text/ws_text/barely_mobile
	savefile_key = "ws_barely_mobile"

/datum/preference/text/ws_text/barely_mobile/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_barely_mobile"] = value

/datum/preference/text/ws_text/immobile
	savefile_key = "ws_immobile"

/datum/preference/text/ws_text/immobile/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_immobile"] = value

/datum/preference/text/ws_text/fatty_blob
	savefile_key = "ws_fatty_blob"

/datum/preference/text/ws_text/fatty_blob/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ws_fatty_blob"] = value

// Muscle!
/datum/preference/text/ws_text/toned
	savefile_key = "ms_toned"

/datum/preference/text/ws_text/toned/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_toned"] = value


/datum/preference/text/ws_text/sporty
	savefile_key = "ms_sporty"

/datum/preference/text/ws_text/sporty/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_sporty"] = value


/datum/preference/text/ws_text/athletic
	savefile_key = "ms_athletic"

/datum/preference/text/ws_text/athletic/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_athletic"] = value


/datum/preference/text/ws_text/muscular
	savefile_key = "ms_muscular"

/datum/preference/text/ws_text/muscular/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_muscular"] = value


/datum/preference/text/ws_text/beefy
	savefile_key = "ms_beefy"

/datum/preference/text/ws_text/beefy/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_beefy"] = value


/datum/preference/text/ws_text/herculean
	savefile_key = "ms_herculean"

/datum/preference/text/ws_text/herculean/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_herculean"] = value


/datum/preference/text/ws_text/hulking
	savefile_key = "ms_hulking"

/datum/preference/text/ws_text/hulking/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_hulking"] = value


/datum/preference/text/ws_text/titanic
	savefile_key = "ms_titanic"

/datum/preference/text/ws_text/titanic/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_titanic"] = value


/datum/preference/text/ws_text/mountainous
	savefile_key = "ms_mountainous"

/datum/preference/text/ws_text/mountainous/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["ms_mountainous"] = value
