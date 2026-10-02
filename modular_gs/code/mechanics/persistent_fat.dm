/datum/modular_persistence
	var/real_fat = 0
	var/perma_fat = 0
	var/micro_calorite_poisoning = 0
	/// What is the max amount of hardcore fatty points have we built up as a streak?
	var/hardcore_fatty_max_streak = 0
	/// How many hardcore fatty points have we currently accumulated?
	var/hardcore_fatty_current_streak = 0

/mob/living/carbon/proc/save_persistent_fat(datum/modular_persistence/persistence)
	persistence.real_fat = fatness_real

	persistence.perma_fat = fatness_perma

	// we save this all the time, but we'll only load if we have the prefs
	persistence.micro_calorite_poisoning = micro_calorite_poisoning

	if(HAS_TRAIT(src, TRAIT_HARDCORE_FATTY))
		persistence.hardcore_fatty_current_streak += hardcore_fatty_streak_total

		if(persistence.hardcore_fatty_current_streak > persistence.hardcore_fatty_max_streak)
			persistence.hardcore_fatty_current_streak = persistence.hardcore_fatty_max_streak


/mob/living/carbon/proc/load_persistent_fat(datum/modular_persistence/persistence)
	if (isnull(client))
		return

	if (isnull(client.prefs))
		return

	var/datum/preferences/prefs = client.prefs

	// Do this here rather than saving, because we know that a client has prefs in this instance.
	if(persistence.hardcore_fatty_max_streak)
		client?.give_award(/datum/award/score/hardcore_fatty_streak, src, persistence.hardcore_fatty_max_streak)


	if("Hardcore Fatty" in prefs.all_quirks) // You get all of the fun!
		fatness_real = persistence.real_fat
		fatness_perma = persistence.perma_fat
		micro_calorite_poisoning = persistence.micro_calorite_poisoning
		addtimer(CALLBACK(src, PROC_REF(update_hardcore_fatty_value)), HARDCORE_FATTY_POINT_CHECK_INTERVAL)
		return

	if(persistence.hardcore_fatty_current_streak) // Reset the streak, if you've joined into a round without the quirk
		persistence.hardcore_fatty_current_streak = 0
		to_chat(src, span_boldwarning("Your hardcore fatty streak has been reset!"))

	if (prefs.read_preference(/datum/preference/toggle/weight_gain_persistent))
		fatness_real = persistence.real_fat

	if (prefs.read_preference(/datum/preference/toggle/weight_gain_permanent))
		fatness_perma = persistence.perma_fat

	if (prefs.read_preference(/datum/preference/toggle/severe_fatness_penalty))
		micro_calorite_poisoning = persistence.micro_calorite_poisoning
	else
		persistence.micro_calorite_poisoning = 0

