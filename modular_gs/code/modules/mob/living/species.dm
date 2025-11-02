
/mob/living/carbon/human/proc/update_body_size(mob/living/carbon/human/H, size_change)
	if(!istype(H))
		return

	var/obj/item/organ/genital/butt/butt = H.get_organ_slot(ORGAN_SLOT_BUTT)
	var/obj/item/organ/genital/belly/belly = H.get_organ_slot(ORGAN_SLOT_BELLY)
	var/obj/item/organ/genital/breasts/breasts = H.get_organ_slot(ORGAN_SLOT_BREASTS)
	// var/obj/item/organ/genital/taur_belly/tbelly = H.get_organ_slot(ORGAN_SLOT_TAUR_BELLY)

	if(butt)
		butt.update_size_from_weight(size_change)
	if(belly)
		belly.update_size_from_weight(size_change)
	// if(tbelly)
	// 	if(tbelly.max_genital_size > 0)
	// 		if((tbelly.size + size_change) <= tbelly.max_genital_size)
	// 			tbelly.set_size(size_change)
	// 	else
	// 		tbelly.set_size(size_change)
	if(breasts)
		breasts.update_size_from_weight(size_change)

	// H.genital_override = TRUE
	H.update_body()
	H.update_worn_undersuit()
	H.update_worn_oversuit()

/obj/item/organ/genital/proc/update_size_from_weight(size_change)
	if (max_genital_size > 0 && (set_genital_size + size_change) >= max_genital_size)
		set_size(max_genital_size)
	else
		set_size(size_change + set_genital_size)


/mob/living/carbon/human/proc/handle_fatness_trait(trait, trait_lose, trait_gain, fatness_lose, fatness_gain, chat_lose, chat_gain, weight_stage)
	var/mob/living/carbon/human/H = src
	if(H.fatness < fatness_lose)
		if (chat_lose)
			to_chat(H, chat_lose)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_lose)
			ADD_TRAIT(H, trait_lose, OBESITY)
		update_body_size(H, weight_stage - 1)
	else if(H.fatness >= fatness_gain)
		if (chat_gain)
			to_chat(H, chat_gain)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_gain)
			ADD_TRAIT(H, trait_gain, OBESITY)
		update_body_size(H, weight_stage + 1)

/mob/living/carbon/human/proc/handle_helplessness()
	for (var/helplessness_mechanic in subtypesof(/datum/helplessness))
		var/datum/helplessness/helplessness_datum = new helplessness_mechanic
		helplessness_datum.handle_helplessness(src)

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

/mob/living/carbon/human/proc/apply_fatness_speed_modifiers(fatness_delay)
	var/mob/living/carbon/human/H = src
	var/delay_cap = FATNESS_MAX_MOVE_PENALTY
	if(HAS_TRAIT(H, TRAIT_WEAKLEGS))
		delay_cap = 60
	for(var/datum/fatness_delay_modifier/modifier in H.fatness_delay_modifiers)
		fatness_delay = fatness_delay + modifier.amount
	for(var/datum/fatness_delay_modifier/modifier in H.fatness_delay_modifiers)
		fatness_delay *= modifier.multiplier
	fatness_delay = max(fatness_delay, 0)
	fatness_delay = min(fatness_delay, delay_cap)
	return fatness_delay

/mob/living/carbon/human/proc/handle_fatness()
	// handle_modular_items()
	var/mob/living/carbon/human/H = src
	var/effective_fatness = calculate_effective_fatness()
	// update movement speed
	var/fatness_delay = 0
	if(effective_fatness && !HAS_TRAIT(H, TRAIT_NO_FAT_SLOWDOWN))
		fatness_delay = (effective_fatness / FATNESS_DIVISOR)
		fatness_delay = min(fatness_delay, FATNESS_MAX_MOVE_PENALTY)

		if(HAS_TRAIT(H, TRAIT_STRONGLEGS))
			fatness_delay = fatness_delay * FATNESS_STRONGLEGS_MODIFIER

		if(HAS_TRAIT(H, TRAIT_WEAKLEGS))
			if(effective_fatness <= FATNESS_LEVEL_IMMOBILE)
				fatness_delay += fatness_delay * FATNESS_WEAKLEGS_MODIFIER / 100
			if(effective_fatness > FATNESS_LEVEL_IMMOBILE)
				fatness_delay += (effective_fatness / FATNESS_LEVEL_IMMOBILE) * FATNESS_WEAKLEGS_MODIFIER
				fatness_delay = min(fatness_delay, 60)

	if(fatness_delay)
		fatness_delay = apply_fatness_speed_modifiers(fatness_delay)
		H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/fatness, TRUE, fatness_delay)
	else
		H.remove_movespeed_modifier(/datum/movespeed_modifier/fatness)

	if(HAS_TRAIT(H, TRAIT_BLOB))
		handle_fatness_trait(
			TRAIT_BLOB,
			TRAIT_IMMOBILE,
			null,
			FATNESS_LEVEL_BLOB,
			INFINITY,
			span_notice("You feel like you've regained some mobility!"),
			null,
			9)
		return
	if(HAS_TRAIT(H, TRAIT_IMMOBILE))
		handle_fatness_trait(
			TRAIT_IMMOBILE,
			TRAIT_BARELYMOBILE,
			TRAIT_BLOB,
			FATNESS_LEVEL_IMMOBILE,
			FATNESS_LEVEL_BLOB,
			span_notice("You feel less restrained by your fat!"),
			span_danger("You feel like you've become a mountain of fat!"),
			8)
		return
	if(HAS_TRAIT(H, TRAIT_BARELYMOBILE))
		handle_fatness_trait(
			TRAIT_BARELYMOBILE,
			TRAIT_EXTREMELYOBESE,
			TRAIT_IMMOBILE,
			FATNESS_LEVEL_BARELYMOBILE,
			FATNESS_LEVEL_IMMOBILE,
			span_notice("You feel less restrained by your fat!"),
			span_danger("You feel your belly smush against the floor!"),
			7)
		return
	if(HAS_TRAIT(H, TRAIT_EXTREMELYOBESE))
		handle_fatness_trait(
			TRAIT_EXTREMELYOBESE,
			TRAIT_MORBIDLYOBESE,
			TRAIT_BARELYMOBILE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			FATNESS_LEVEL_BARELYMOBILE,
			span_notice("You feel less restrained by your fat!"),
			span_danger("You feel like you can barely move!"),
			6)
		return
	if(HAS_TRAIT(H, TRAIT_MORBIDLYOBESE))
		handle_fatness_trait(
			TRAIT_MORBIDLYOBESE,
			TRAIT_OBESE,
			TRAIT_EXTREMELYOBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			FATNESS_LEVEL_EXTREMELY_OBESE,
			span_notice("You feel a bit less fat!"),
			span_danger("You feel your belly rest heavily on your lap!"),
			5)
		return
	if(HAS_TRAIT(H, TRAIT_OBESE))
		handle_fatness_trait(
			TRAIT_OBESE,
			TRAIT_VERYFAT,
			TRAIT_MORBIDLYOBESE,
			FATNESS_LEVEL_OBESE,
			FATNESS_LEVEL_MORBIDLY_OBESE,
			span_notice("You feel like you've lost weight!"),
			span_danger("Your thighs begin to rub against each other."),
			4)
		return
	if(HAS_TRAIT(H, TRAIT_VERYFAT))
		handle_fatness_trait(
			TRAIT_VERYFAT,
			TRAIT_FATTER,
			TRAIT_OBESE,
			FATNESS_LEVEL_VERYFAT,
			FATNESS_LEVEL_OBESE,
			span_notice("You feel like you've lost weight!"),
			span_danger("You feel like you're starting to get really heavy."),
			3)
		return
	if(HAS_TRAIT(H, TRAIT_FATTER))
		handle_fatness_trait(
			TRAIT_FATTER,
			TRAIT_ROUNDED,
			TRAIT_VERYFAT,
			FATNESS_LEVEL_FATTER,
			FATNESS_LEVEL_VERYFAT,
			span_notice("You feel like you've lost weight!"),
			span_danger("Your clothes creak quietly!"),
			2)
		return
	if(HAS_TRAIT(H, TRAIT_ROUNDED))
		handle_fatness_trait(
			TRAIT_ROUNDED,
			null,
			TRAIT_FATTER,
			FATNESS_LEVEL_FAT,
			FATNESS_LEVEL_FATTER,
			span_notice("You feel fit again!"),
			span_danger("You feel even plumper!"),
			1)
	else
		handle_fatness_trait(
			null,
			null,
			TRAIT_ROUNDED,
			0,
			FATNESS_LEVEL_FAT,
			null,
			span_danger("You suddenly feel blubbery!"),
			0)
