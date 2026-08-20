/// Updates the size of genitals after weight has been gained or lost
/mob/living/carbon/proc/update_body_size(size_change)
	var/obj/item/organ/genital/butt/butt = get_organ_slot(ORGAN_SLOT_BUTT)
	var/obj/item/organ/genital/belly/belly = get_organ_slot(ORGAN_SLOT_BELLY)
	var/obj/item/organ/genital/breasts/breasts = get_organ_slot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/taur_body/horselike/taur_belly = get_organ_slot(ORGAN_SLOT_EXTERNAL_TAUR)

	if(butt)
		butt.update_size_from_weight(size_change)
	if(belly)
		belly.update_size_from_weight(size_change)
	if(breasts)
		breasts.update_size_from_weight(size_change)
	if (taur_belly && taur_belly.mutantpart_info[MUTANT_INDEX_NAME] == "Drake")
		taur_belly.set_size_from_weight(size_change)
	if(breasts)
		breasts.update_size_from_weight(size_change)

	update_body()
	update_worn_undersuit()
	update_worn_oversuit()

/obj/item/organ/genital/proc/update_size_from_weight(size_change)
	if (max_genital_size > 0 && (set_genital_size + size_change) >= max_genital_size)
		set_size(max_genital_size)
	else
		set_size(size_change + set_genital_size)

/**
 * Handles applying and removing the appropriate weight stage trait
 * 
 * Returns TRUE if the weight stage has changed
 * 
 * Returne FALSE otherwise
 */
/mob/living/carbon/proc/handle_fatness_trait(trait, trait_lose, trait_gain, fatness_lose, fatness_gain, chat_lose, chat_gain, weight_stage)
	if(fatness < fatness_lose)
		if (chat_lose)
			to_chat(src, chat_lose)
		if (trait)
			REMOVE_TRAIT(src, trait, OBESITY)
		if (trait_lose)
			ADD_TRAIT(src, trait_lose, OBESITY)
		update_body_size(weight_stage - 1)
		return TRUE
	else if(fatness >= fatness_gain)
		if (chat_gain)
			to_chat(src, chat_gain)
		if (trait)
			REMOVE_TRAIT(src, trait, OBESITY)
		if (trait_gain)
			ADD_TRAIT(src, trait_gain, OBESITY)
		update_body_size(weight_stage + 1)
		return TRUE

	return FALSE

/// Handles applying and removing helplessness mechanics
/mob/living/carbon/proc/handle_helplessness()
	for (var/datum/helplessness/helplessness_mechanic as anything in GLOB.helplessness_mechanics)
		helplessness_mechanic.handle_helplessness(src)

/datum/movespeed_modifier/fatness
	id = "fat"
	variable = TRUE

/mob/living/carbon
	var/list/fatness_delay_modifiers

/datum/fatness_delay_modifier
	var/name
	var/amount = 0
	var/multiplier = 1

/mob/living/carbon/proc/add_fat_delay_modifier(name = "", amount = 0, multiplier = 1)
	var/find_name = FALSE
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		if(modifier.name == name && find_name == FALSE)
			modifier.amount = amount
			modifier.multiplier = multiplier
			find_name = TRUE
	if(find_name == FALSE)
		var/datum/fatness_delay_modifier/new_modifier = new()
		new_modifier.name = name
		new_modifier.amount = amount
		new_modifier.multiplier = multiplier
		LAZYADD(fatness_delay_modifiers, new_modifier)

/mob/living/carbon/proc/remove_fat_delay_modifier(name)
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		if(modifier.name == name)
			LAZYREMOVE(fatness_delay_modifiers, modifier)

/mob/living/carbon/proc/apply_fatness_speed_modifiers(fatness_delay)
	var/delay_cap = FATNESS_MAX_MOVE_PENALTY
	if(HAS_TRAIT(src, TRAIT_WEAKLEGS))
		delay_cap = WEAKLEGS_MAX_MOVE_PENALTY
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		fatness_delay = fatness_delay + modifier.amount
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		fatness_delay *= modifier.multiplier
	fatness_delay = max(fatness_delay, 0)
	fatness_delay = min(fatness_delay, delay_cap)
	return fatness_delay

/// handles calculating the speed delay from fatness
/mob/living/carbon/proc/handle_fatness_speed_modifier()
	var/effective_fatness = calculate_effective_fatness()
	// update movement speed
	var/fatness_delay = 0
	if(effective_fatness && !HAS_TRAIT(src, TRAIT_NO_FAT_SLOWDOWN))
		fatness_delay = (effective_fatness / FATNESS_DIVISOR)
		fatness_delay = min(fatness_delay, FATNESS_MAX_MOVE_PENALTY)

		if(HAS_TRAIT(src, TRAIT_STRONGLEGS))
			fatness_delay = fatness_delay * FATNESS_STRONGLEGS_MODIFIER

		if(HAS_TRAIT(src, TRAIT_WEAKLEGS))
			fatness_delay *= FATNESS_WEAKLEGS_MODIFIER

	if(fatness_delay)
		fatness_delay = apply_fatness_speed_modifiers(fatness_delay)
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/fatness, TRUE, fatness_delay)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/fatness)

/// handles preparing weight stage traits for application via `handle_fatness_trait`. Returns the return value of `handle_fatness_trait`
/mob/living/carbon/proc/handle_fatness()
	if(HAS_TRAIT(src, TRAIT_BLOB))
		return handle_fatness_trait(
			TRAIT_BLOB,
			TRAIT_IMMOBILE,
			null,
			FATNESS_LEVEL_BLOB,
			INFINITY,
			span_notice("You feel like you've regained some mobility!"),
			null,
			9)
	if(HAS_TRAIT(src, TRAIT_IMMOBILE))
		return handle_fatness_trait(
			TRAIT_IMMOBILE,
			TRAIT_BARELYMOBILE,
			TRAIT_BLOB,
			FATNESS_LEVEL_IMMOBILE,
			FATNESS_LEVEL_BLOB,
			span_notice("You feel less restrained by your fat!"),
			span_danger("You feel like you've become a mountain of fat!"),
			8)
	if(HAS_TRAIT(src, TRAIT_BARELYMOBILE))
		return handle_fatness_trait(
			TRAIT_BARELYMOBILE,
			TRAIT_EXTREMELYOBESE,
			TRAIT_IMMOBILE,
			FATNESS_LEVEL_BARELYMOBILE,
			FATNESS_LEVEL_IMMOBILE,
			span_notice("You feel less restrained by your fat!"),
			span_danger("You feel your belly smush against the floor!"),
			7)
	if(HAS_TRAIT(src, TRAIT_EXTREMELYOBESE))
		return handle_fatness_trait(
			TRAIT_EXTREMELYOBESE,
			TRAIT_MORBIDLYOBESE,
			TRAIT_BARELYMOBILE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			FATNESS_LEVEL_BARELYMOBILE,
			span_notice("You feel less restrained by your fat!"),
			span_danger("You feel like you can barely move!"),
			6)
	if(HAS_TRAIT(src, TRAIT_MORBIDLYOBESE))
		return handle_fatness_trait(
			TRAIT_MORBIDLYOBESE,
			TRAIT_OBESE,
			TRAIT_EXTREMELYOBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			span_notice("You feel a bit less fat!"),
			span_danger("You feel your belly rest heavily on your lap!"),
			5)
	if(HAS_TRAIT(src, TRAIT_OBESE))
		return handle_fatness_trait(
			TRAIT_OBESE,
			TRAIT_VERYFAT,
			TRAIT_MORBIDLYOBESE,
			FATNESS_LEVEL_OBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			span_notice("You feel like you've lost weight!"),
			span_danger("Your thighs begin to rub against each other."),
			4)
	if(HAS_TRAIT(src, TRAIT_VERYFAT))
		return handle_fatness_trait(
			TRAIT_VERYFAT,
			TRAIT_FATTER,
			TRAIT_OBESE,
			FATNESS_LEVEL_VERYFAT,
			FATNESS_LEVEL_OBESE,
			span_notice("You feel like you've lost weight!"),
			span_danger("You feel like you're starting to get really heavy."),
			3)
	if(HAS_TRAIT(src, TRAIT_FATTER))
		return handle_fatness_trait(
			TRAIT_FATTER,
			TRAIT_ROUNDED,
			TRAIT_VERYFAT,
			FATNESS_LEVEL_FATTER,
			FATNESS_LEVEL_VERYFAT,
			span_notice("You feel like you've lost weight!"),
			span_danger("Your clothes creak quietly!"),
			2)
	if(HAS_TRAIT(src, TRAIT_ROUNDED))
		return handle_fatness_trait(
			TRAIT_ROUNDED,
			null,
			TRAIT_FATTER,
			FATNESS_LEVEL_FAT,
			FATNESS_LEVEL_FATTER,
			span_notice("You feel fit again!"),
			span_danger("You feel even plumper!"),
			1)
	else
		return handle_fatness_trait(
			null,
			null,
			TRAIT_ROUNDED,
			0,
			FATNESS_LEVEL_FAT,
			null,
			span_danger("You suddenly feel blubbery!"),
			0)
