/mob/living
	var/burpslurring = 0 //GS13 - necessary due to "say" being defined by mob/living

/mob/living/carbon
	//Due to the changes needed to create the system to hide fatness, here's some notes:
	// -If you are making a mob simply gain or lose weight, use adjust_fatness. Try to not touch the variables directly unless you know 'em well
	// -fatness is the value a mob is being displayed and calculated as by most things. Changes to fatness are not permanent
	// -fatness_real is the value a mob is actually at, even if it's being hidden. For permanent changes, use this one
	// PLEASE NOTE - If you add more fatness variables and you want them to show on scales, please add them to `modular_gs\code\modules\mob\living\carbon\weight_helpers.dm`!

	//What level of fatness is the parent mob currently at?
	var/fatness = 0
	//The list of items/effects that are being added/subtracted from our real fatness
	var/fat_hiders = list()
	//The actual value a mob is at. Is equal to fatness if fat_hider is FALSE.
	var/fatness_real = 0
	//Permanent fatness, which sticks around between rounds
	var/fatness_perma = 0
	///At what rate does the parent mob gain weight? 1 = 100%
	var/weight_gain_rate = 1
	//At what rate does the parent mob lose weight? 1 = 100%
	var/weight_loss_rate = 1
	/// modifier for weight gain rate. Don't modify this directly, instead use the set and add_weight_gain_modifier procs
	var/list/weight_gain_modifiers = list()
	/// modifier for weight loss rate. Don't modify this directly, instead use the set and add_weight_loss_modifier procs
	var/list/weight_loss_modifiers = list()
	/// whether we flip the sign on the final WG rate. This will make any fattening action make you lose weight instead
	var/flip_gain_rate = FALSE
	/// whether we flip the sign on the final WL rate. This will make any slimming action make you gain weight
	var/flip_loss_rate = FALSE
	//Variable related to door stuckage code
	var/doorstuck = 0
	/// What is the maximum amount of weight we can put on?
	var/max_weight

	var/fullness = 20
	/// by how much we reduce the mob fullness compared to what it actually is
	var/fullness_reduction = 0
	var/fullness_reduction_timer = 0 // When was the last time they emoted to reduce their fullness

	/// How many humanoid mobs have been digested by this mob?
	var/carbons_digested = 0

/**
* Adjusts the fatness level of the parent mob.
*
* * adjustment_amount - adjusts how much weight is gained or loss. Positive numbers add weight.
* * type_of_fattening - what type of fattening is being used. Look at the traits in fatness.dm for valid options.
* * ignore_rate - do we want to ignore the mob's weight gain/loss rate? This is only here for niche uses.
*/
/mob/living/carbon/proc/adjust_fatness(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM, ignore_rate = FALSE)
	if(!adjustment_amount || !type_of_fattening)
		return FALSE

	if(!HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && client?.prefs)
		if(!check_weight_prefs(type_of_fattening))
			return FALSE

	var/amount_to_change = adjustment_amount

	var/gain_rate = get_weight_gain_rate()
	var/lose_rate = get_weight_loss_rate()

	if(!ignore_rate)
		if(adjustment_amount > 0)
			amount_to_change = amount_to_change * gain_rate
		else
			amount_to_change = amount_to_change * lose_rate

	fatness_real += amount_to_change
	fatness_real = max(fatness_real, MINIMUM_FATNESS_LEVEL) //It would be a little silly if someone got negative fat.

	if(max_weight && !HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		fatness_real = min(fatness_real, (max_weight - 1))

	fatness = fatness_real //Make their current fatness their real fatness

	hiders_apply()	//Check and apply hiders
	perma_apply()	//Check and apply for permanent fat
	xwg_resize()	//Apply XWG

	/*
	// Handle Awards
	if(client)
		if(fatness > FATNESS_LEVEL_BLOB)
			client.give_award(/datum/award/achievement/fat/blob, src)
		if(fatness > 10000)
			client.give_award(/datum/award/achievement/fat/milestone_one, src)
		if(fatness > 25000)
			client.give_award(/datum/award/achievement/fat/milestone_two, src)
		if(fatness > 50000)
			client.give_award(/datum/award/achievement/fat/milestone_three, src)
		if(fatness > 100000)
			client.give_award(/datum/award/achievement/fat/milestone_four, src)
		if(fatness > 500000)
			client.give_award(/datum/award/achievement/fat/milestone_five, src)
		if(fatness > 1000000)
			client.give_award(/datum/award/achievement/fat/milestone_six, src)
		if(fatness > 10000000)
			client.give_award(/datum/award/achievement/fat/milestone_seven, src)
		*/

	return TRUE

/// returns the total value of all WG modifiers
/mob/living/carbon/proc/get_weight_gain_modifiers()
	var/total_modifier = 0
	for (var/key in weight_gain_modifiers)
		total_modifier += clamp(weight_gain_modifiers[key], -2, 2)
	return total_modifier

/// returns the total value of all WL modifiers
/mob/living/carbon/proc/get_weight_loss_modifiers()
	var/total_modifier = 0
	for (var/key in weight_loss_modifiers)
		total_modifier += clamp(weight_loss_modifiers[key], -2, 2)
	return total_modifier

/**
 * Adds a weight gain modifier to the modifier list
 * 
 * If the modifier doesn't exist yet, adds it as an entry and sets it's value. If it does exist, adds value to it.
 * 
 * Arguments: 
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/add_weight_gain_modifier(source, value)
	if (weight_gain_modifiers[source])
		weight_gain_modifiers[source] += value
		return
	
	weight_gain_modifiers[source] = value

/**
 * Sets a weight gain modifier in the modifier list
 * 
 * Will always set the modifier to the set value, regardless of the previously stored value
 * Arguments:
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/set_weight_gain_modifier(source, value)
	weight_gain_modifiers[source] = value

/**
 * Adds a weight loss modifier to the modifier list
 * 
 * If the modifier doesn't exist yet, adds it as an entry and sets it's value. If it does exist, adds value to it.
 * 
 * Arguments: 
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/add_weight_loss_modifier(source, value)
	if (weight_loss_modifiers[source])
		weight_loss_modifiers[source] += value
		return
	
	weight_loss_modifiers[source] = value

/**
 * Sets a weight loss modifier in the modifier list
 * 
 * Will always set the modifier to the set value, regardless of the previously stored value
 * Arguments:
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/set_weight_loss_modifier(source, value)
	weight_loss_modifiers[source] = value

/// returns the current value of given weight gain modifier. If such a modifier doesn't exits, returns 0
/mob/living/carbon/proc/get_weight_gain_modifier(source)
	if (weight_gain_modifiers[source])
		return weight_gain_modifiers[source]
	
	return 0

/// returns the current value of given weight loss modifier. If such a modifier doesn't exits, returns 0
/mob/living/carbon/proc/get_weight_loss_modifier(source)
	if (weight_loss_modifiers[source])
		return weight_loss_modifiers[source]
	
	return 0

/// completely removes a weight gain modifier from the list
/mob/living/carbon/proc/remove_weight_gain_modifier(source)
	if (!weight_gain_modifiers[source])
		return
	
	weight_gain_modifiers.Remove(source)

/// completely removes a weight loss modifier from the list
/mob/living/carbon/proc/remove_weight_loss_modifier(source)
	if (!weight_loss_modifiers[source])
		return
	
	weight_loss_modifiers.Remove(source)

/// removes all weight gain modifiers
/mob/living/carbon/proc/clear_weight_gain_modifiers()
	weight_gain_modifiers.Cut()

/// removes all weight loss modifiers
/mob/living/carbon/proc/clear_weight_loss_modifiers()
	weight_loss_modifiers.Cut()

/// returns the final weight gain rate of a carbon, taking into account all modifiers, flips, traits etc
/mob/living/carbon/proc/get_weight_gain_rate()
	var/local_gain_rate = weight_gain_rate

	if (HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		local_gain_rate = max(0.2, local_gain_rate)
	
	local_gain_rate += get_weight_gain_modifiers()
	
	if (flip_gain_rate)
		local_gain_rate = -local_gain_rate
	
	return local_gain_rate

/// returns the final weight loss rate of a carbon, taking into account all modifiers, flips, traits etc
/mob/living/carbon/proc/get_weight_loss_rate()
	var/local_loss_rate = weight_loss_rate

	if (HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		local_loss_rate = max(0.2, local_loss_rate)
	
	local_loss_rate += get_weight_loss_modifiers()
	
	if (flip_loss_rate)
		local_loss_rate = -local_loss_rate
	
	return local_loss_rate

/mob/living/carbon/get_fullness(only_consumable)
	. = ..()
	fullness = .	// old fullness
	return max(0, fullness - fullness_reduction)

/mob/living/carbon/proc/fullness_reduction()
	var/max_fullness_reduction = max(fullness * 2, 2000)
	fullness_reduction -= 15
	fullness_reduction = clamp(fullness_reduction, 0, max_fullness_reduction)

/mob/living/carbon/fully_heal(admin_revive)
	fatness = 0
	fatness_real = 0
	. = ..()

///Checks the parent mob's prefs to see if they can be fattened by the fattening_type
/mob/living/carbon/proc/check_weight_prefs(type_of_fattening = FATTENING_TYPE_ITEM)
	if(HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && !client.prefs) //Comment this second part out
		return TRUE

	if(!client?.prefs || !type_of_fattening)
		return FALSE

	switch(type_of_fattening)
		if(FATTENING_TYPE_ITEM)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_items))
				return FALSE

		if(FATTENING_TYPE_FOOD)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food))
				return FALSE

		if(FATTENING_TYPE_CHEM)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_chems))
				return FALSE

		if(FATTENING_TYPE_WEAPON)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_weapons))
				return FALSE

		if(FATTENING_TYPE_MAGIC)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_magic))
				return FALSE

		if(FATTENING_TYPE_VIRUS)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_viruses))
				return FALSE

		if(FATTENING_TYPE_NANITES)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_nanites))
				return FALSE

		if(FATTENING_TYPE_ATMOS)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_atmos))
				return FALSE

		if(FATTENING_TYPE_MOBS)
			if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_mobs))
				return FALSE

		if(FATTENING_TYPE_WEIGHT_LOSS)
			if(HAS_TRAIT(src, TRAIT_WEIGHT_LOSS_IMMUNE))
				return FALSE

	return TRUE

	// THE FATNESS HIDING GUIDE!!!
	// HOW 2 FATNESS HIDE
	//Step 1) Grab a thing that will add or reduce fatness!
	//Step 2) Give it a character.hider_add(src) and a character.hider_remove(src) depending on the conditions you want it to meet for which it will add or remove itself from messing with a character's fatness!
	//Step 3) Give it a proc/fat_hide([character argument]), with a return that will give the amount to shift that character's fatness by!
	//Step 4) There is no step 4, you did it bucko!
	//Wanna see an example? Search for /obj/item/bluespace_belt !!!

/mob/living/carbon/proc/hider_add(hide_source)
	if(!(hide_source in fat_hiders))
		fat_hiders += hide_source

	return TRUE

/mob/living/carbon/proc/hider_remove(hide_source)
	if(hide_source in fat_hiders)
		fat_hiders -= hide_source
	return TRUE

/mob/living/carbon/proc/hiders_calc()
	var/hiders_value = 0
	for(var/hider in fat_hiders)
		var/hide_values = hider:fat_hide(src)
		if(!islist(hide_values))
			hiders_value += hide_values
		else
			for(var/hide_value in hide_values)
				hiders_value += hide_value
	return hiders_value

/mob/living/carbon/proc/hiders_apply()
	if(fat_hiders) //do we have any hiders active?
		var/fatness_over = hiders_calc() //calculate the sum of all hiders
		fatness = fatness + fatness_over //Then, make their current fatness the sum of their real plus/minus the calculated amount
		if(max_weight) //Check their prefs
			fatness = min(fatness, (max_weight - 1)) //And make sure it's not above their preferred max

/mob/living/carbon/proc/perma_apply()
	if(fatness_perma > 0)	//Check if we need to make calcs at all
		fatness = fatness + fatness_perma	//Add permanent fat to fatness
		if(max_weight)	//Check for max weight prefs
			fatness = min(fatness, (max_weight - 1))	//Apply max weight prefs

/mob/living/carbon/proc/adjust_perma(adjustment_amount, type_of_fattening = FATTENING_TYPE_ITEM, ignore_rate = FALSE)
	if(isnull(client))
		return FALSE
	if(!client.prefs.read_preference(/datum/preference/toggle/weight_gain_permanent))
		return FALSE

	if(!adjustment_amount || !type_of_fattening)
		return FALSE

	if(!HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER) && client?.prefs)
		if(!check_weight_prefs(type_of_fattening))
			return FALSE

	var/amount_to_change = adjustment_amount

	var/local_gain_rate = weight_gain_rate
	var/local_lose_rate = weight_loss_rate

	if (HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		local_gain_rate = 0.2
		local_lose_rate = 0.2


	if(!ignore_rate)
		if(adjustment_amount > 0)
			amount_to_change = amount_to_change * local_gain_rate
		else
			amount_to_change = amount_to_change * local_lose_rate

	fatness_perma += amount_to_change
	fatness_perma = max(fatness_perma, MINIMUM_FATNESS_LEVEL)

	if(max_weight && !HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		fatness_perma = min(fatness_perma, (max_weight - 1))

/mob/living/carbon/human/handle_breathing(times_fired)
	. = ..()
	fatness = fatness_real
	hiders_apply()
	perma_apply()
	xwg_resize()

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

/mob/living/carbon/proc/applyFatnessDamage(amount)
	if(!client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_weapons)) // If we can't fatten them through weapons, apply stamina damage
		adjustStaminaLoss(amount)
		return TRUE

	var/fat_to_add = ((amount * CONFIG_GET(number/damage_multiplier)) * FAT_DAMAGE_TO_FATNESS)
	adjust_fatness(fat_to_add, FATTENING_TYPE_WEAPON)
	return fat_to_add

/mob/living/carbon/proc/applyPermaFatnessDamage(amount)
	if (isnull(client))
		return

	if (!client.prefs.read_preference(/datum/preference/toggle/weight_gain_permanent)) // If we cant apply permafat, apply regular fat
		return applyFatnessDamage(amount)

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
		applyFatnessDamage(damage)
	if (damagetype == PERMA_FAT)
		applyPermaFatnessDamage(damage)

	. = ..()
