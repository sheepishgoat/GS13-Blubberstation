/datum/preference/toggle/master_wg_pref
	category = MASTER_WG_PREF
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "master_wg_pref"
	default_value = FALSE

/datum/preference/toggle/master_wg_pref/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/starting_fatness
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "starting_fatness"
	minimum = FATNESS_LEVEL_NONE
	maximum = FATNESS_LEVEL_BLOB

/datum/preference/numeric/starting_fatness/create_default_value()
	return FATNESS_LEVEL_NONE

/datum/preference/numeric/starting_fatness/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.fatness_real = value

/datum/preference/numeric/weight_gain_rate
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_gain_rate"
	minimum = MIN_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	maximum = MAX_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	step = 0.01

/datum/preference/numeric/weight_gain_rate/create_default_value()
	return DEFAULT_PREFS_WEIGHT_GAIN_AND_LOSS_RATE

/datum/preference/numeric/weight_gain_rate/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.weight_gain_rate = value

/datum/preference/numeric/weight_loss_rate
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_loss_rate"
	minimum = MIN_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	maximum = MAX_PREFS_WEIGHT_GAIN_AND_LOSS_RATE
	step = 0.01

/datum/preference/numeric/weight_loss_rate/create_default_value()
	return DEFAULT_PREFS_WEIGHT_GAIN_AND_LOSS_RATE

/datum/preference/numeric/weight_loss_rate/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.weight_loss_rate = value

/datum/preference/numeric/max_weight
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "max_weight"
	minimum = 0
	maximum = INFINITY

/datum/preference/numeric/max_weight/create_default_value()
	return 0

/datum/preference/numeric/max_weight/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.max_weight = value


/datum/preference/toggle/weight_gain_persistent
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_gain_persistent"
	default_value = FALSE

/datum/preference/toggle/weight_gain_persistent/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/weight_gain_permanent
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "weight_gain_permanent"
	default_value = FALSE

/datum/preference/toggle/weight_gain_permanent/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/severe_fatness_penalty
	category = WG_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "severe_fatness_penalty"
	default_value = FALSE

/datum/preference/toggle/severe_fatness_penalty/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/safe_bursting
	category = BLUEBERRY_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "safe_bursting"
	default_value = TRUE

/datum/preference/toggle/safe_bursting/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/see_bursting
	category = BLUEBERRY_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "see_bursting"
	default_value = FALSE

/datum/preference/toggle/see_bursting/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/bursting_leave_gibs
	category = BLUEBERRY_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "bursting_leave_gibs"
	default_value = FALSE

/datum/preference/toggle/bursting_leave_gibs/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/automatic_burst
	category = BLUEBERRY_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "automatic_bursting"
	default_value = FALSE

/datum/preference/toggle/automatic_burst/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/numeric/helplessness/blueberry_max_before_burst
	category = BLUEBERRY_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blueberry_max_before_burst"
	minimum = 0
	maximum = INFINITY

/datum/preference/numeric/helplessness/blueberry_lives
	category = BLUEBERRY_PREFERENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blueberry_lives"
	minimum = 0
	maximum = INFINITY

/datum/preference/numeric/helplessness/glutton_fullness_before_burst
	category = GLUTTON_BURSTING_PREFRENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "glutton_fullness_before_burst"
	minimum = 0
	maximum = INFINITY

/datum/preference/numeric/helplessness/glutton_fatness_before_burst
	category = GLUTTON_BURSTING_PREFRENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "glutton_fatness_before_burst"
	minimum = 0
	maximum = INFINITY

/datum/preference/choiced/glutton_bursting_type
	category = GLUTTON_BURSTING_PREFRENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "glutton_bursting_type"

/datum/preference/choiced/glutton_bursting_type/init_possible_values()
	return list(
		BURSTING_TYPE_PREF_DISABLE,
		BURSTING_TYPE_PREF_SAFE,
		BURSTING_TYPE_PREF_INJURE,
		BURSTING_TYPE_PREF_CRIT,
		BURSTING_TYPE_PREF_FATAL,
		BURSTING_TYPE_PREF_PERMA_FATAL
	)

/datum/preference/choiced/glutton_bursting_type/create_default_value()
	return "Disabled"

/datum/preference/choiced/glutton_bursting_type/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/glutton_see_bursting
	category = GLUTTON_BURSTING_PREFRENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "glutton_see_bursting"
	default_value = FALSE

/datum/preference/toggle/glutton_see_bursting/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/glutton_leave_gibs
	category = GLUTTON_BURSTING_PREFRENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "glutton_leave_gibs"
	default_value = FALSE

/datum/preference/toggle/glutton_leave_gibs/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/glutton_enable_messages
	category = GLUTTON_BURSTING_PREFRENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "glutton_enable_messages"
	default_value = FALSE

/datum/preference/toggle/glutton_enable_messages/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/toggle/glutton_enable_sounds
	category = GLUTTON_BURSTING_PREFRENCES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "glutton_enable_sounds"
	default_value = FALSE

/datum/preference/toggle/glutton_enable_sounds/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return
