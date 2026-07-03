#define CALORITE_POISONING	"calorite_poisoning"
#define CALORITE_HUNGER		"calorite_hunger"
#define CALORITE_STARVATION	"calorite_starvation"

/mob/living/carbon
	/// how severe is their calorite poisoning? 100 = 100%
	var/micro_calorite_poisoning = 0

/mob/living/carbon/proc/handle_calorite_poisoning()
	micro_calorite_poisoning = clamp(micro_calorite_poisoning, 0, 100)

	if (micro_calorite_poisoning < 0.1)	// sanity to make sure we aren't applying stupid effects for very low doses
		remove_weight_gain_modifier(CALORITE_POISONING)
		remove_weight_loss_modifier(CALORITE_POISONING)
		remove_movespeed_modifier(/datum/movespeed_modifier/calorite_poisoning)
		return

	var/calorite_poisoning = micro_calorite_poisoning / 100	// we assume 100 micro calorite poisoning is 100%, so we divide by 100 to get the percentage value
	adjust_calorite_poisoning(-0.0001)

	if (isnull(client))
		return
	
	if (isnull(client.prefs))
		return

	if (!client.prefs.read_preference(/datum/preference/toggle/severe_fatness_penalty))
		remove_weight_gain_modifier(CALORITE_POISONING)
		remove_weight_loss_modifier(CALORITE_POISONING)
		remove_movespeed_modifier(/datum/movespeed_modifier/calorite_poisoning)

	set_weight_gain_modifier(CALORITE_POISONING, calorite_poisoning)
	set_weight_loss_modifier(CALORITE_POISONING, -calorite_poisoning)

	adjust_hunger(calorite_poisoning * 2)

	if (calorite_poisoning > 0.3)
		if (prob(5))
			emote("gurgle")

	if (calorite_poisoning > 0.4)
		remove_quirk(/datum/quirk/fat_aversion)

	if (calorite_poisoning > 0.5)
		if (get_fullness() < NUTRITION_LEVEL_FAT)
			add_mood_event(CALORITE_HUNGER, /datum/mood_event/calorite_poisoning_hunger)
		if (get_fullness() < NUTRITION_LEVEL_WELL_FED)
			add_mood_event(CALORITE_STARVATION, /datum/mood_event/calorite_poisoning_starving)


	if (calorite_poisoning > 0.7)
		add_quirk(/datum/quirk/fat_affinity)

	if (calorite_poisoning > 0.8)
		if (get_fullness() < FULLNESS_LEVEL_BLOATED)
			add_mood_event(CALORITE_HUNGER, /datum/mood_event/calorite_poisoning_hunger)
		if (get_fullness() < NUTRITION_LEVEL_FAT)
			add_mood_event(CALORITE_STARVATION, /datum/mood_event/calorite_poisoning_starving)
		add_movespeed_modifier(/datum/movespeed_modifier/calorite_poisoning)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/calorite_poisoning)

	if (calorite_poisoning > 0.9)
		adjust_fatness(10 * (calorite_poisoning - 0.9), FATTENING_TYPE_MAGIC)
	
	if (calorite_poisoning > 0.97)
		adjust_perma(1, FATTENING_TYPE_MAGIC, TRUE)

/// returns true if we changed it, false if we didn't
/mob/living/carbon/proc/adjust_calorite_poisoning(amount)
	if (isnull(client))
		return FALSE
	
	if (isnull(client.prefs))
		return FALSE

	if (!client.prefs.read_preference(/datum/preference/toggle/severe_fatness_penalty))
		return FALSE

	micro_calorite_poisoning += amount
	return TRUE

/datum/mood_event/calorite_poisoning_hunger
	description = span_bolddanger("I'm so hungry!")
	mood_change = -6
	timeout = 3 MINUTES

/datum/mood_event/calorite_poisoning_starving
	description = span_bolddanger("I'M STARVING!!")
	mood_change = -8
	timeout = 3 MINUTES

/datum/movespeed_modifier/calorite_poisoning
	id = CALORITE_POISONING
	variable = FALSE
	conflicts_with = CALORITE_POISONING
	multiplicative_slowdown = 0.6

#undef CALORITE_POISONING
#undef CALORITE_HUNGER
#undef CALORITE_STARVATION
