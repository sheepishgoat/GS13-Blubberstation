/datum/mutation/adipohazard
	name = "Adipohazard"
	desc = "A mutation that causes swelling upon touching the mutated person."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>Everything around you feels soft...</span>"
	text_lose_indication = "<span class='notice'>The soft feeling around you disappears.</span>"
	difficulty = 14
	instability = 30
	power_coeff = 1
	var/fat_add = 2

/datum/mutation/adipohazard/on_life()
	. = ..()
	if(owner.pulledby != null && iscarbon(owner.pulledby))
		var/mob/living/carbon/C = owner.pulledby
		var/pwr = GET_MUTATION_POWER(src)
		C.adjust_fatness(get_fatness_bonus(owner) + (fat_add * pwr), FATTENING_TYPE_RADIATIONS)
		if(C.grab_state >= GRAB_AGGRESSIVE)
			C.adjust_fatness(get_fatness_bonus(owner) + ((fat_add * 2) * pwr), FATTENING_TYPE_RADIATIONS)
		if(prob(5))
			var/add_text = pick("You feel softer.", "[owner] feels warm to the touch", "It's so nice to touch [owner].", "You don't want to let go of [owner].")
			to_chat(C, "<span class='notice'>[add_text]</span>")
	if(owner.pulling != null && iscarbon(owner.pulling))
		var/mob/living/carbon/C = owner.pulling
		var/pwr = GET_MUTATION_POWER(src)
		C.adjust_fatness(get_fatness_bonus(owner) + (fat_add * pwr), FATTENING_TYPE_RADIATIONS)
		if(C.grab_state >= GRAB_AGGRESSIVE)
			C.adjust_fatness(get_fatness_bonus(owner) + ((fat_add * 2) * pwr), FATTENING_TYPE_RADIATIONS)
		if(prob(5))
			var/add_text = pick("You feel softer.", "[owner] feels warm to the touch", "It's so nice for [owner] to touch.", "You don't want [owner] to let go of you.")
			to_chat(C, "<span class='notice'>[add_text]</span>")

/datum/mutation/adipohazard/proc/get_fatness_bonus(mob/living/carbon/user)
	var/fatness_level = get_fatness_level_name(user.fatness)
	var/fatness_bonus = 0
	switch(fatness_level)
		if("Fat", "Fatter")
			fatness_bonus = 1
		if("Very Fat", "Obese")
			fatness_bonus = 2
		if("Very Obese", "Extremely Obese")
			fatness_bonus = 3
		if("Barely Mobile", "Immobile")
			fatness_bonus = 4
		if("Blob")
			fatness_bonus = 5
	return fatness_bonus

/datum/mutation/adipohazard/proc/fatten(mob/living/carbon/toucher, amount = 1)
	toucher.adjust_fatness(get_fatness_bonus(owner) + (amount * GET_MUTATION_POWER(src)), FATTENING_TYPE_RADIATIONS)
	to_chat(toucher, "<span class='notice'>That felt so nice!</span>")

/obj/item/dnainjector/antiadipohazard
	name = "\improper DNA injector (Anti-Adipohazard)"
	desc = "No hugs?"
	remove_mutations = list(/datum/mutation/adipohazard)

/obj/item/dnainjector/adipohazard
	name = "\improper DNA injector (Adipohazard)"
	desc = "It's hugs time!"
	add_mutations = list(/datum/mutation/adipohazard)

/datum/reagent/adipoluri
	name = "Adipoluri"
	description = "A medicinal gel used for massages to adipose tissue. Touching someone covered in this gel helps treat their wounds and burns, being more effective the fatter they are, but causes the fat to multiply"
	color = "#E0E0E0"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM //same as C2s
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/chemical_reaction/medicine/adipoluri
	results = list(/datum/reagent/adipoluri = 2)
	required_reagents = list(/datum/reagent/medicine/granibitaluri = 1, /datum/reagent/consumable/nutriment/fat/oil/corn = 1)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_BRUTE | REACTION_TAG_BURN

/datum/reagent/adipoluri/proc/get_fatness_bonus(mob/living/carbon/human/user)
	var/fatness_level = get_fatness_level_name(user.fatness)
	var/fatness_bonus = 0
	switch(fatness_level)
		if("Fat", "Fatter")
			fatness_bonus = 1
		if("Very Fat", "Obese")
			fatness_bonus = 2
		if("Very Obese", "Extremely Obese")
			fatness_bonus = 3
		if("Barely Mobile", "Immobile")
			fatness_bonus = 4
		if("Blob")
			fatness_bonus = 5
	return fatness_bonus

/datum/reagent/adipoluri/proc/fatten(mob/living/carbon/owner, amount = 1)
	if(!ishuman(owner))
		return
	owner.adjust_fatness(get_fatness_bonus(owner) + amount + 12, FATTENING_TYPE_CHEM)
	owner.adjust_brute_loss(-(1 + (get_fatness_bonus(owner)/2)), updating_health = FALSE, required_bodytype = affected_bodytype)
	owner.adjust_fire_loss(-((1 + get_fatness_bonus(owner))/2), updating_health = FALSE, required_bodytype = affected_bodytype)
	to_chat(owner, "<span class='notice'>That felt nice...</span>")

/obj/item/hand_item/kisser/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	. = ..()
	if(!.)
		return

	var/datum/mutation/adipohazard/touched_mutation
	for(var/datum/mutation/adipohazard/HM in taker.dna.mutations)
		if(istype(HM, /datum/mutation/adipohazard))
			touched_mutation = HM
	if(touched_mutation)
		touched_mutation.fatten(offerer, 10)

	var/datum/mutation/adipohazard/touching_mutation
	for(var/datum/mutation/adipohazard/HM in offerer.dna.mutations)
		if(istype(HM, /datum/mutation/adipohazard))
			touching_mutation = HM
	if(touching_mutation)
		touching_mutation.fatten(taker, 10)

	var/datum/reagent/adipoluri/touched_chem = taker.reagents?.has_reagent(/datum/reagent/adipoluri)
	if(touched_chem)
		touched_chem.fatten(taker, 10)

/mob/living/carbon/proc/disarm_fatten(mob/living/carbon/target)
	if(!ishuman(src))
		return

	var/datum/mutation/adipohazard/touched_mutation
	for(var/datum/mutation/adipohazard/HM in target.dna.mutations)
		if(istype(HM, /datum/mutation/adipohazard))
			touched_mutation = HM

	var/datum/mutation/adipohazard/touching_mutation
	for(var/datum/mutation/adipohazard/HM in dna.mutations)
		if(istype(HM, /datum/mutation/adipohazard))
			touching_mutation = HM

	var/datum/reagent/adipoluri/touched_chem = target.reagents?.has_reagent(/datum/reagent/adipoluri)

	if(zone_selected == BODY_ZONE_PRECISE_MOUTH) //Face slap
		var/target_on_help_and_unarmed = !target.combat_mode && !target.get_active_held_item()
		if(target_on_help_and_unarmed || HAS_TRAIT(target, TRAIT_RESTRAINED))
			if(touched_mutation)
				touched_mutation.fatten(src)
			if(touching_mutation)
				touching_mutation.fatten(target)
			if(touched_chem)
				touched_chem.fatten(target)

	if(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == src.dir) //Butt slap
		if(!HAS_TRAIT(target, TRAIT_PERSONALSPACE)) // || ((target.stat == UNCONSCIOUS) || (target.handcuffed))
			if(touched_mutation)
				touched_mutation.fatten(src, 5)
			if(touching_mutation)
				touching_mutation.fatten(target, 5)
			if(touched_chem)
				touched_chem.fatten(target, 5)

/mob/living/carbon/help_shake_act(mob/living/carbon/helper, force_friendly)
	. = ..()

	if(on_fire)
		return

	if(helper == src)
		return

	var/datum/mutation/adipohazard/touched_mutation
	for(var/datum/mutation/adipohazard/HM in dna.mutations)
		if(istype(HM, /datum/mutation/adipohazard))
			touched_mutation = HM

	var/datum/mutation/adipohazard/touching_mutation
	for(var/datum/mutation/adipohazard/HM in helper.dna.mutations)
		if(istype(HM, /datum/mutation/adipohazard))
			touching_mutation = HM

	var/datum/reagent/adipoluri/touched_chem = reagents?.has_reagent(/datum/reagent/adipoluri)

	if(body_position == LYING_DOWN) //SHAKE
		if(buckled)
			return
		if(touched_mutation)
			touched_mutation.fatten(helper, 3)
		if(touching_mutation)
			touching_mutation.fatten(src, 3)
		if(touched_chem)
			touched_chem.fatten(src, 3)

	else if(helper.zone_selected == BODY_ZONE_PRECISE_MOUTH) //BOOP
		if(HAS_TRAIT(src, TRAIT_QUICKREFLEXES) && (src.stat != UNCONSCIOUS) && !INCAPACITATED_IGNORING(src, INCAPABLE_RESTRAINTS) && !(HAS_TRAIT(src, TRAIT_SENSITIVESNOUT)))
			return
		if(touched_mutation)
			touched_mutation.fatten(helper)
		if(touching_mutation)
			touching_mutation.fatten(src)
		if(touched_chem)
			touched_chem.fatten(src)

	else if(check_zone(helper.zone_selected) == BODY_ZONE_HEAD && get_bodypart(BODY_ZONE_HEAD)) //HEADPAT
		if(HAS_TRAIT(src, TRAIT_OVERSIZED) && !HAS_TRAIT(helper, TRAIT_OVERSIZED))
			return
		else if(HAS_TRAIT(src, TRAIT_QUICKREFLEXES) && (src.stat != UNCONSCIOUS) && !INCAPACITATED_IGNORING(src, INCAPABLE_RESTRAINTS))
			return
		if(touched_mutation)
			touched_mutation.fatten(helper, 2)
		if(touching_mutation)
			touching_mutation.fatten(src, 2)
		if(touched_chem)
			touched_chem.fatten(src, 2)

	else
		if (helper.grab_state >= GRAB_AGGRESSIVE) //BEARHUG
			if(touched_mutation)
				touched_mutation.fatten(helper, 5)
			if(touching_mutation)
				touching_mutation.fatten(src, 5)
			if(touched_chem)
				touched_chem.fatten(src, 5)

		else
			if (HAS_TRAIT(src, TRAIT_QUICKREFLEXES) && (src.stat != UNCONSCIOUS) && !INCAPACITATED_IGNORING(src, INCAPABLE_RESTRAINTS)) //HUG
				return
			if(touched_mutation)
				touched_mutation.fatten(helper, 4)
			if(touching_mutation)
				touching_mutation.fatten(src, 4)
			if(touched_chem)
				touched_chem.fatten(src, 4)

/obj/item/reagent_containers/medigel/adipoluri
	name = "soft massage oil"
	desc = "A medical gel applicator bottle, containing a substance meant to be rubbed on fat tissure to mend bruises and burns"
	icon = 'modular_gs/icons/obj/fat_massage.dmi'
	icon_state = "fattyoil"
	list_reagents = list(/datum/reagent/adipoluri = 60)

/obj/machinery/vending/barbervend
	gs_premium = list(
		/obj/item/reagent_containers/medigel/adipoluri = 3,
	)
