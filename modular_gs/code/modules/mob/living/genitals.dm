// Nothing in this is a genital, but whatever lol. We ball.
//The Butt.

// /obj/item/organ/genital/butt
// 	name = "butt"
// 	desc = "You see a pair of asscheeks."
// 	icon = 'modular_gs/icons/obj/genitals/butt.dmi'
// 	icon_state = "butt"
// 	slot = ORGAN_SLOT_BUTT
// 	zone = BODY_ZONE_PRECISE_GROIN
// 	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/butt
// 	aroused = AROUSAL_CANT

// 	mutantpart_key = ORGAN_SLOT_BUTT
// 	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))

// /obj/item/organ/genital/butt/get_description_string(datum/sprite_accessory/genital/gas)
// 	var/size_name
// 	switch(round(genital_size))
// 		if(1)
// 			size_name = "average"
// 		if(2)
// 			size_name = "sizable"
// 		if(3)
// 			size_name = "squeezable"
// 		if(4)
// 			size_name = "hefty"
// 		if(5)
// 			size_name = pick("massive", "very generous")
// 		if(6)
// 			size_name = pick("gigantic", "big bubbly", "enormous")
// 		if(7)
// 			size_name = pick("unfathomably large", "extreme")
// 		if(8)
// 			size_name = pick("absolute dumptruck", "humongous", "dummy thick")
// 		else
// 			size_name = "nonexistent"

// 	return "You see a [LOWER_TEXT(gas.icon_state)] of [size_name] asscheeks."

// /obj/item/organ/genital/butt/get_sprite_size_string()
// 	. = "[genital_type]_[floor(genital_size)]"
// 	if(uses_skintones)
// 		. += "_s"

/obj/item/organ/genital/butt/set_size(size)
	genital_size = max(size, set_genital_size)
	genital_size = min(genital_size, max_genital_size, BUTT_MAX_SIZE)
	update_sprite_suffix()

/obj/item/organ/genital/butt/build_from_dna(datum/dna/DNA, associated_key)
	set_genital_size = DNA.features["butt_size"]
	max_genital_size = DNA.features["max_butt_size"]

	return ..()

// /obj/item/organ/genital/butt/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
// 	if(DNA.features["butt_uses_skintones"])
// 		uses_skintones = accessory.has_skintone_shading
// 	return ..()

// /datum/bodypart_overlay/mutant/genital/butt
// 	feature_key = ORGAN_SLOT_BUTT
// 	layers = EXTERNAL_ADJACENT | EXTERNAL_FRONT

// /datum/bodypart_overlay/mutant/genital/butt/get_global_feature_list()
// 	return SSaccessories.sprite_accessories[ORGAN_SLOT_BUTT]

//The Tummy.
// /obj/item/organ/genital/belly
// 	name = "belly"
// 	desc = "You see a belly on their midsection."
// 	icon = null //apparently theres no organ sprite?
// 	icon_state = null
// 	drop_when_organ_spilling = FALSE
// 	slot = ORGAN_SLOT_BELLY
// 	zone = BODY_ZONE_CHEST
// 	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/belly
// 	genital_location = CHEST
// 	aroused = AROUSAL_CANT

// 	mutantpart_key = ORGAN_SLOT_BELLY
// 	mutantpart_info = list(MUTANT_INDEX_NAME = "Belly", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))

// /obj/item/organ/genital/belly/get_sprite_size_string()
// 	. = "[genital_type]_[floor(genital_size)]"
// 	if(uses_skintones)
// 		. += "_s"

/obj/item/organ/genital/belly/set_size(size)
	var/old_size = genital_size
	if(size > old_size)
		to_chat(owner, span_warning("Your guts [pick("swell up to", "gurgle into", "expand into", "plump up into", "grow eagerly into", "fatten up into", "distend into")] a larger midsection."))
	else if (size < old_size)
		to_chat(owner, span_warning("Your guts [pick("shrink down to", "decrease into", "wobble down into", "diminish into", "deflate into", "contracts into")] a smaller midsection."))

	genital_size = max(size, set_genital_size)
	genital_size = min(genital_size, max_genital_size, BELLY_MAX_SIZE)
	update_sprite_suffix()

/obj/item/organ/genital/belly/build_from_dna(datum/dna/DNA, associated_key)
	set_genital_size = DNA.features["belly_size"]
	max_genital_size = DNA.features["max_belly_size"]

	return ..()

// /obj/item/organ/genital/belly/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
// 	if(DNA.features["belly_uses_skintones"])
// 		uses_skintones = accessory.has_skintone_shading
// 	return ..()

// /obj/item/organ/genital/belly/get_description_string(datum/sprite_accessory/genital/gas)
// 	var/size_name
// 	switch(round(genital_size))
// 		if(1)
// 			size_name = "average"
// 		if(2)
// 			size_name = "round"
// 		if(3)
// 			size_name = "squishable"
// 		if(4)
// 			size_name = "fat"
// 		if(5)
// 			size_name = "sagging"
// 		if(6)
// 			size_name = "gigantic"
// 		if(7 to INFINITY)
// 			size_name = pick("massive", "unfathomably bulging", "enormous", "very generous", "humongous", "big bubbly")
// 		else
// 			size_name = "nonexistent"

// 	var/returned_string = "You see a [size_name] [round(genital_size) >= 4 ? "belly, it's quite large." : "belly in [owner?.p_their() ? owner?.p_their() : "their"] midsection"]."
// 	return returned_string

// /datum/bodypart_overlay/mutant/genital/belly
// 	feature_key = ORGAN_SLOT_BELLY
// 	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND

// /datum/bodypart_overlay/mutant/genital/belly/get_global_feature_list()
// 	return SSaccessories.sprite_accessories[ORGAN_SLOT_BELLY]

// The Tig Bitties.
/obj/item/organ/genital/breasts/set_size(size)
	genital_size = max(size, set_genital_size)		// mmmmmmm, they're getting so big~
	genital_size = min(genital_size, max_genital_size, MAX_BREASTS_SIZE)
	var/breasts_capacity = 1
	switch(genital_type)
		if("pair")
			breasts_capacity = 2
		if("quad")
			breasts_capacity = 2.5
		if("sextuple")
			breasts_capacity = 3
	internal_fluid_maximum = genital_size * breasts_capacity * 60
	if(internal_fluid_maximum > 3500)
		internal_fluid_maximum = 3500
	reagents.maximum_volume = internal_fluid_maximum
	var/volume_to_remove = max(0, reagents.total_volume - reagents.maximum_volume)
	reagents.remove_reagent(internal_fluid_datum, volume_to_remove)
	update_sprite_suffix()

/obj/item/organ/genital/breasts/on_life(seconds_per_tick, times_fired)
	. = ..()
	if(!lactates)
		return

	var/mob/living/carbon/human/affected_human = owner
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp) || !istype(affected_human))
		return

	if(reagents.total_volume >= reagents.maximum_volume)
		return

	// var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED / NUTRITION_MULTIPLIER)) / NUTRITION_MULTIPLIER) * (reagents.maximum_volume / BREASTS_MULTIPLIER) * BASE_MULTIPLIER
	var/regen = reagents.maximum_volume * 0.05 * seconds_per_tick
	var/free_space = reagents.maximum_volume - reagents.total_volume
	if(regen > free_space)
		regen = free_space // so we aren't draining nutrition for milk that isn't actually being generated
	reagents.add_reagent(internal_fluid_datum, regen)

/datum/sprite_accessory/genital/breasts/alt_GS13/pair
	name = "Pair (Alt GS13)"
	icon = 'modular_gs/icons/obj/genitals/breasts_onmob.dmi'
	icon_state = "pair_gs"
	max_size = 18

/datum/sprite_accessory/genital/breasts/alt_GS13/pair_smooth //smoother variant, no nipples
	name = "Pair (Alt GS13, No Nipples)"
	icon = 'modular_gs/icons/obj/genitals/breasts_smooth_onmob.dmi'
	icon_state = "pair_gs_smooth"
	max_size = 18

/datum/sprite_accessory/genital/breasts/alt_GS13/teshari // Teshari only (duh)
	name = "Pair (Teshari)"
	icon = 'modular_gs/icons/obj/genitals/teshbreasts.dmi'
	icon_state = "pair_tesh"
	max_size = 15
