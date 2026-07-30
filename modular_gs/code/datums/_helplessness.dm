GLOBAL_LIST_EMPTY_TYPED(helplessness_mechanics, /datum/helplessness)
/**
 * A datum responsible for handling helplessness mechanics.
 * Check out [modular_gs/code/datums/helplessness/helplessness.dm] for examples on how to extend this
 * and its procs.
 * 
 * Created and maintained by Swan on Gain Station 13 discord server, if you have any questions 
 * or are interested in expanding it's functionality feel free to reach out to me.
 * Or just tell me what a good little coder boy I am that'll make me happy too.
 */
/datum/helplessness
	abstract_type = /datum/helplessness
	/// the helplessness mechanic this triggers
	var/helplessness_trait = 0
	/// default BFI value at which this triggers - essentially the value used by quirks
	var/default_trigger_weight = 0
	/// quirk trait which overrides the pref
	var/override_quirk = 0
	/// reference to the preference
	var/datum/preference/numeric/helplessness/preference = null
	/// message we send on player gaining this helplessness
	var/gain_message = ""
	/// message we send on player losing this helplessness
	var/lose_message = ""

/*
oh yeah I'm such a good little coder boy mmmmh~ ❤
mommy is gonna be so proud of her good little coder boy for writing such good code
ahhhh~! It's all documented too~ 🥵
*/

/**
 * Starting proc, used as a starting point to get everything running. Calls other procs that 
 * are supposed to handle helplessness logic. Override those, not this one.
 * 
 * Returns FALSE if we haven't applied the helplessness traits.
 * 
 * Returns TRUE if we did.
 */
/datum/helplessness/proc/handle_helplessness(mob/living/carbon/human/fatty)
	SHOULD_NOT_OVERRIDE(TRUE)

	if (sanity_checks(fatty) == FALSE)
		disable_helplessness(fatty)
		return FALSE
	
	var/trigger_weight = get_trigger_weight(fatty)

	var/effective_fatness = fatty.calculate_effective_fatness()

	if (trigger_weight <= 0)
		disable_helplessness(fatty)
		return FALSE
	
	if (effective_fatness < trigger_weight)
		disable_helplessness(fatty)
		return FALSE

	return apply_helplessness(fatty, trigger_weight, effective_fatness)

/**
 * Performs sanity checks - if we have a client, do they have prefs etc. Basically checking
 * for things that'd make running the rest of the code pointless.
 * Other procs here rely on running this before them so make sure you don't fucking break it or daddy
 * will be really mad.
 * 
 * Returns FALSE if we shouldn't run further.
 * 
 * Returns TRUE if we should.
 */
/datum/helplessness/proc/sanity_checks(mob/living/carbon/human/fatty)
	PROTECTED_PROC(TRUE)

	if(HAS_TRAIT(fatty, TRAIT_NO_HELPLESSNESS))
		return FALSE
	
	if (isnull(fatty.client))
		return FALSE

	if (isnull(fatty.client.prefs))
		return FALSE
	
	return TRUE

/**
 * Returns the weight at which the helplessness mechanic triggers.
 * 
 * Separate proc primarily for the weak/strong legs traits.
 * 
 * Returns the BFI value at which the helplessness mechanic will trigger.
 */
/datum/helplessness/proc/get_trigger_weight(mob/living/carbon/human/fatty)
	PROTECTED_PROC(TRUE)

	// we assume sanity_checks were run already and that we do, indeed, have both
	// a client and that client has preferences
	var/datum/preferences/preferences = fatty.client.prefs

	var/trigger_weight = preferences.read_preference(preference.type)

	// if the player has a related helplessness quirk, override the trigger weight with the default
	if (HAS_TRAIT(fatty, override_quirk))
		trigger_weight = default_trigger_weight

	return trigger_weight

/**
 * Applies helplessness trait(s). Basically, if you're here, means that you can apply the trait,
 * and that it is not present on the mob yet.
 * Override this for custom behaviour, adding/deleting multiple trait under one helplessness pref etc.
 * 
 * Returns FALSE if the trait was not applied.
 * 
 * Returns TRUE if the trais was applied.
 */
/datum/helplessness/proc/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	PROTECTED_PROC(TRUE)

	if (!HAS_TRAIT_FROM(fatty, helplessness_trait, HELPLESSNESS_TRAIT))
		to_chat(fatty, span_warning(gain_message))
		ADD_TRAIT(fatty, helplessness_trait, HELPLESSNESS_TRAIT)
		return TRUE
		
	return FALSE

/**
 * Disables the helplessness mechanics. Basically, if you're here, you know you have to remove the trait
 * Override this if you need to do some cleanup of your own
 * 
 * returns TRUE if the trait was present and was removed
 * 
 * returns FALSE if the trait wasn't removed (because it wasn't there to begin with. You can use this behavior to speed up
 * removing multiple traits since AFAIK a single if (bool) check is faster than looking up if you have trait X or not)
 */
/datum/helplessness/proc/disable_helplessness(mob/living/carbon/human/fatty)
	PROTECTED_PROC(TRUE)

	if (HAS_TRAIT_FROM(fatty, helplessness_trait, HELPLESSNESS_TRAIT))
		to_chat(fatty, span_notice(lose_message))
		REMOVE_TRAIT(fatty, helplessness_trait, HELPLESSNESS_TRAIT)
		return TRUE

	return FALSE

/proc/populate_helplessness_mechanics()
	for (var/helplessness_mechanic in subtypesof(/datum/helplessness))
		var/datum/helplessness/helplessness_datum = new helplessness_mechanic
		GLOB.helplessness_mechanics.Add(helplessness_datum)
