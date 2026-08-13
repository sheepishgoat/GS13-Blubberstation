/**
* Adjusts the fatness level of the parent mob.
*
* * adjustment_amount - adjusts how much weight is gained or loss. Positive numbers add weight.
* * type_of_fattening - what type of fattening is being used. Look at the traits in fatness.dm for valid options.
* * ignore_rate - do we want to ignore the mob's weight gain/loss rate? This is only here for niche uses.
*
* * returns the amount of BFI applied onto target
*/
/mob/living/carbon/proc/adjust_fatness(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM, ignore_rate = FALSE)
	if(!adjustment_amount || !type_of_fattening)
		return FALSE

	if(!check_weight_prefs(type_of_fattening))
		return FALSE

	adjustment_amount = get_fatness_adjustment_amount(adjustment_amount, ignore_rate)

	if(fatness_real + adjustment_amount < 0)
		adjustment_amount = -fatness_real

	fatness_real += adjustment_amount

	if(max_weight && !HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		fatness_real = min(fatness_real, (max_weight - 1))

	calculate_fatness()

	SEND_SIGNAL(src, COMSIG_FATNESS_REAL_CHANGED, fatness_real)
	return adjustment_amount

/**
* Adjusts the perma fatness level of the parent mob.
*
* * adjustment_amount - adjusts how much weight is gained or loss. Positive numbers add weight.
* * type_of_fattening - what type of fattening is being used. Look at the traits in fatness.dm for valid options.
* * ignore_rate - do we want to ignore the mob's weight gain/loss rate? This is only here for niche uses.
*
* * returns the amount of BFI applied onto target
*/
/mob/living/carbon/proc/adjust_perma(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM, ignore_rate = FALSE)
	if(!adjustment_amount || !type_of_fattening)
		return FALSE

	if(!check_weight_prefs(type_of_fattening, TRUE))
		return FALSE

	adjustment_amount = get_fatness_adjustment_amount(adjustment_amount, ignore_rate)

	if(fatness_perma + adjustment_amount < 0)
		adjustment_amount = -fatness_perma

	fatness_perma += adjustment_amount

	if(max_weight && !HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		fatness_perma = min(fatness_perma, (max_weight - 1))

	calculate_fatness()

	SEND_SIGNAL(src, COMSIG_FATNESS_PERMA_CHANGED, fatness_perma)
	return adjustment_amount

/**
 * Returns the actual amount of fatness that should be applied to a mob when WG/L rate modifiers are applied.
 * If `adjustment_amount` if positive, uses WG rate. If `adjustment_amount` is negative uses the WL rate.
 *
 * Params:
 *
 * `adjustment_amount` - the base amount of fatness we want to apply
 * `ignore_rate` - whether we take into consideration the WG/L rates. Default is `FALSE`
 *
 * Returns `adjustment_amount` if `ignore_rate` is set to `TRUE`. Returns `adjustment_amount` multiplied by
 * our current WG/L rate if `ignore_rate` is set to `FALSE`
*/
/mob/living/carbon/proc/get_fatness_adjustment_amount(adjustment_amount, ignore_rate = FALSE)
	if (ignore_rate)
		return adjustment_amount

	if(adjustment_amount > 0)
		var/gain_rate = get_weight_gain_rate()
		adjustment_amount = adjustment_amount * gain_rate
	else
		var/lose_rate = get_weight_loss_rate()
		adjustment_amount = adjustment_amount * lose_rate

	return adjustment_amount

/// Remove all of the real fatness from a mob.
/mob/living/carbon/proc/fully_heal_fatness(remove_perma = FALSE, custom_remove_text, custom_perma_remove_text)
	var/regular_remove_text = "You feel much lighter."
	var/perma_remove_text = "The weight that you've held onto for so long, just vanishes away."

	if(custom_remove_text)
		regular_remove_text = custom_remove_text
	if(custom_perma_remove_text)
		perma_remove_text = perma_remove_text

	fatness = 0
	fatness_real = 0

	if(regular_remove_text)
		to_chat(src, span_boldnicegreen(regular_remove_text))

	if(remove_perma)
		fatness_perma = 0
		if(perma_remove_text)
			to_chat(src, span_boldnicegreen(perma_remove_text))

/// Virtual sin forgiveness
/mob/living/carbon/proc/fully_heal_fatness_shitpost(remove_perma = FALSE)
	var/regular_text = "I absolve you of your sins, you have been forgiven"
	var/perma_text = ""

	if(remove_perma)
		perma_text = regular_text
		regular_text = ""

	fully_heal_fatness(remove_perma, regular_text, perma_text)

/**
 * Checks the parent mob's prefs to see if they can be fattened by the fattening_type
 *
 * type_of_fattening - the type of fattening we are being affected by, as defined in
 * `code/__DEFINES/~~gs_defines/misc.dm`
 * perma - whether we are adjusting perma fatness or not, default is FALSE
 *
 * returns TRUE if our prefs match or we for some reason override them.
 *
 * returns FALSE if our prefs don't match and we don't have anything that overrides them
*/
/mob/living/carbon/proc/check_weight_prefs(type_of_fattening = FATTENING_TYPE_ITEM, perma = FALSE)
	if(HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		return TRUE

	if (type_of_fattening == FATTENING_TYPE_ALMIGHTY)
		return TRUE

	if(!client?.prefs || !type_of_fattening)
		return FALSE

	if (perma && !client.prefs.read_preference(/datum/preference/toggle/weight_gain_permanent))
		return FALSE

	switch(type_of_fattening)
		if(FATTENING_TYPE_ITEM)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_items)

		if(FATTENING_TYPE_FOOD)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food)

		if(FATTENING_TYPE_CHEM)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_chems)

		if(FATTENING_TYPE_WEAPON)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_weapons)

		if(FATTENING_TYPE_MAGIC)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_magic)

		if(FATTENING_TYPE_VIRUS)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_viruses)

		if(FATTENING_TYPE_NANITES)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_nanites)

		if(FATTENING_TYPE_ATMOS)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_atmos)

		if(FATTENING_TYPE_MOBS)
			return client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_mobs)

		if(FATTENING_TYPE_WEIGHT_LOSS)
			return (!HAS_TRAIT(src, TRAIT_WEIGHT_LOSS_IMMUNE))

	return FALSE

/mob/living/carbon/proc/perma_apply()
	fatness = fatness + fatness_perma	// we're adding it to fatness rather than fatness_real because here we SHOULD be after the hiders were applied
	if(max_weight && !HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		fatness = min(fatness, (max_weight - 1))

/// Handles calculating our resulting `fatness` from our `fatness_real`, `fatness_perma` as well as any hiders we may have
/mob/living/carbon/proc/calculate_fatness()
	fatness = fatness_real
	hiders_apply()
	perma_apply()
	xwg_resize()
	SEND_SIGNAL(src, COMSIG_FATNESS_CHANGED, fatness)

/// Handles weight gain from digesting food/stomach contents
/mob/living/carbon/proc/handle_weight_gain()
	calculate_fatness()

	handle_fatness_speed_modifier()
	// `handle_fatness` returns the return value of `handle_fatness_trait`,
	// which returns `TRUE` if the weight has changed and `FALSE` if it hasn't
	// as such, we only update modular items sprites if the weight stage has changed
	if (handle_fatness())
		handle_modular_items()

	fullness_adjustment()
	handle_helplessness()

	if (handle_bursting()) //We want to skip the rest if we exploded
		return

	switch(fatness)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/blob)

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/immobile)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/barelymobile)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/extremelyobese)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/morbidlyobese)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/obese)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/veryfat)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/fatter)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/fat)

		if(0 to FATNESS_LEVEL_FAT)
			clear_alert("fatness")

	switch(muscle)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/mountainous)

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/titanic)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/hulking)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/herculean)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/beefy)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/muscular)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/athletic)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/sporty)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/toned)

		if(0 to FATNESS_LEVEL_FAT)
			clear_alert("muscle")

/proc/get_fatness_level_name(fatness_amount)
	if(fatness_amount < FATNESS_LEVEL_FAT)
		return "Normal"
	if(fatness_amount < FATNESS_LEVEL_FATTER)
		return "Fat"
	if(fatness_amount < FATNESS_LEVEL_VERYFAT)
		return "Fatter"
	if(fatness_amount < FATNESS_LEVEL_OBESE)
		return "Very Fat"
	if(fatness_amount < FATNESS_LEVEL_MORBIDLY_OBESE)
		return "Obese"
	if(fatness_amount < FATNESS_LEVEL_EXTREMELY_OBESE)
		return "Very Obese"
	if(fatness_amount < FATNESS_LEVEL_BARELYMOBILE)
		return "Extremely Obese"
	if(fatness_amount < FATNESS_LEVEL_IMMOBILE)
		return "Barely Mobile"
	if(fatness_amount < FATNESS_LEVEL_BLOB)
		return "Immobile"

	return "Blob"

/// Finds what the next fatness level for the parent mob would be based off of fatness_real.
/mob/living/carbon/proc/get_next_fatness_level()
	if(fatness_real < FATNESS_LEVEL_FAT)
		return FATNESS_LEVEL_FAT
	if(fatness_real < FATNESS_LEVEL_FATTER)
		return FATNESS_LEVEL_FATTER
	if(fatness_real < FATNESS_LEVEL_VERYFAT)
		return FATNESS_LEVEL_VERYFAT
	if(fatness_real < FATNESS_LEVEL_OBESE)
		return FATNESS_LEVEL_OBESE
	if(fatness_real < FATNESS_LEVEL_MORBIDLY_OBESE)
		return FATNESS_LEVEL_MORBIDLY_OBESE
	if(fatness_real < FATNESS_LEVEL_EXTREMELY_OBESE)
		return FATNESS_LEVEL_EXTREMELY_OBESE
	if(fatness_real < FATNESS_LEVEL_BARELYMOBILE)
		return FATNESS_LEVEL_BARELYMOBILE
	if(fatness_real < FATNESS_LEVEL_IMMOBILE)
		return FATNESS_LEVEL_IMMOBILE
	if(fatness_real < FATNESS_LEVEL_BLOB)
		return FATNESS_LEVEL_BLOB

	return FATNESS_LEVEL_BLOB

/// How much real fatness does the current mob have to gain until they reach the next level? Return FALSE if they are maxed out.
/mob/living/carbon/proc/fatness_until_next_level()
	var/needed_fatness = get_next_fatness_level() - fatness_real
	needed_fatness = max(needed_fatness, 0)

	return needed_fatness

/mob/living/carbon/proc/apply_fatness_damage(amount)
	if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_weapons)) // If we can't fatten them through weapons, apply stamina damage
		adjust_stamina_loss(amount)
		return TRUE

	var/fat_to_add = ((amount * CONFIG_GET(number/damage_multiplier)) * FAT_DAMAGE_TO_FATNESS)
	adjust_fatness(fat_to_add, FATTENING_TYPE_WEAPON)
	return fat_to_add

/mob/living/carbon/proc/apply_perma_fatness_damage(amount)
	if (isnull(client))
		return

	if (!client.prefs.read_preference(/datum/preference/toggle/weight_gain_permanent)) // If we cant apply permafat, apply regular fat
		return apply_fatness_damage(amount)

	var/fat_to_add = ((amount * CONFIG_GET(number/damage_multiplier)) * PERMA_FAT_DAMAGE_TO_FATNESS)
	adjust_perma(fat_to_add, FATTENING_TYPE_WEAPON)
	return fat_to_add

/mob/living/carbon/apply_damage(
	damage = 0,
	damagetype = BRUTE,
	def_zone = null,
	blocked = 0,
	forced = FALSE,
	spread_damage = FALSE,
	wound_bonus = 0,
	exposed_wound_bonus = 0,
	sharpness = NONE,
	attack_direction = null,
	attacking_item,
	wound_clothing = TRUE,
)
	if (damagetype == FAT)
		apply_fatness_damage(damage)
	if (damagetype == PERMA_FAT)
		apply_perma_fatness_damage(damage)

	. = ..()
