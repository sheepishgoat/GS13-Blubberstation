/datum/preference/choiced/erp_status_feed
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_feed"

/datum/preference/choiced/erp_status_feed/init_possible_values()
	return list("Yes - Switch", "Yes - Feeder", "Yes - Feedee", "Check OOC Notes", "Ask (L)OOC", "No", "Yes")

/datum/preference/choiced/erp_status_feed/create_default_value()
	return "No"

/datum/preference/choiced/erp_status_feed/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_feed/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_feed/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_feed_nc
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_feed_nc"

/datum/preference/choiced/erp_status_feed_nc/init_possible_values()
	return list("No", "Check OOC Notes", "Ask (LOOC)", "Roleplay First", "Talk First", "Fatten On Sight (Yes)",)

/datum/preference/choiced/erp_status_feed_nc/create_default_value()
	return "No"

/datum/preference/choiced/erp_status_feed_nc/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_feed_nc/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_feed_nc/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_muscle
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_muscle"

/datum/preference/choiced/erp_status_muscle/init_possible_values()
	return list("Yes - Switch", "Yes - Trainer", "Yes - Trainee", "Check OOC Notes", "Ask (L)OOC", "No", "Yes")

/datum/preference/choiced/erp_status_muscle/create_default_value()
	return "No"

/datum/preference/choiced/erp_status_muscle/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_muscle/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_muscle/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/erp_status_inflation
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "erp_status_pref_inflation"

/datum/preference/choiced/erp_status_inflation/init_possible_values()
	return list("Yes - Switch", "Yes - Inflator", "Yes - Inflatee", "Check OOC Notes", "Ask (L)OOC", "No", "Yes")

/datum/preference/choiced/erp_status_inflation/create_default_value()
	return "No"

/datum/preference/choiced/erp_status_inflation/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_erp_preferences)

/datum/preference/choiced/erp_status_inflation/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/erp_status_inflation/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

