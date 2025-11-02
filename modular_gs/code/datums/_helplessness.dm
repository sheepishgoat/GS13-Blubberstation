/**
 * A datum responsible for handling helplessness mechanics.
 * Check out [modular_gs/code/datums/helplessness/helplessness.dm] for examples on how to extend this
 * and it's procs.
 * 
 * Created and maintained by Swan on Gain Station 13 discord server, if you have any questions 
 * or are interested in expanding it's functionality feel free to reach out to me.
 * Or just tell me what a good little coder boy I am that'll make me happy too.
 */
/datum/helplessness
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
		return FALSE
	
	var/trigger_weight = get_trigger_weight(fatty)

	var/effective_fatness = fatty.calculate_effective_fatness()

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
 * Compares trigger weight and (effective) fatness, and applies/removes helplessness traits accordingly.
 * Override this for custom behaviour, adding/deleting multiple trait under one helplessness pref etc.
 * 
 * Returns FALSE when the trait is not applied/active.
 * 
 * Returns TRUE when the trais is applied/active.
 */
/datum/helplessness/proc/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	PROTECTED_PROC(TRUE)

	if (trigger_weight <= 0)
		if (HAS_TRAIT_FROM(fatty, helplessness_trait, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, helplessness_trait, HELPLESSNESS_TRAIT)
		
		return FALSE

	if (!HAS_TRAIT_FROM(fatty, helplessness_trait, HELPLESSNESS_TRAIT))
		if (fatness >= trigger_weight)
			to_chat(fatty, span_warning(gain_message))
			ADD_TRAIT(fatty, helplessness_trait, HELPLESSNESS_TRAIT)
			return TRUE
		
		return FALSE
		
	else if (fatness < trigger_weight)
		to_chat(fatty, span_notice(lose_message))
		REMOVE_TRAIT(fatty, helplessness_trait, HELPLESSNESS_TRAIT)
		return FALSE
	
	return TRUE
