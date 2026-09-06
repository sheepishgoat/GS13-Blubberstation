// The quirk handling all of this is defined in [modular_gs/code/datums/quirks/neutral/water_sponde.dm]
/datum/reagent/water
	var/bloat_coeff = 3.5

/datum/reagent/water/on_mob_add(mob/living/living, amount)
	if(HAS_TRAIT(living, TRAIT_WATER_SPONGE))
		if(iscarbon(living))
			var/mob/living/carbon/carbon = living
			carbon.hider_add(src)
	. = ..()

/datum/reagent/water/on_mob_delete(mob/living/living)
	if(HAS_TRAIT(living, TRAIT_WATER_SPONGE))
		if(iscarbon(living))
			var/mob/living/carbon/carbon = living
			carbon.hider_remove(src)
	. = ..()

/datum/reagent/water/expose_atom(atom/exposed_atom, reac_volume, methods)
	. = ..()
	if (!iscarbon(exposed_atom))
		return
	var/mob/living/carbon/carbon = exposed_atom
	if(HAS_TRAIT(carbon, TRAIT_WATER_SPONGE))
		if(methods & TOUCH)
			carbon.reagents.add_reagent(/datum/reagent/water, reac_volume/2)
		if(methods & VAPOR)
			carbon.reagents.add_reagent(/datum/reagent/water, reac_volume/3)

/datum/reagent/water/proc/fat_hide(mob/living/carbon/user)
	return volume * bloat_coeff

/obj/machinery/shower/process(seconds_per_tick)
	..()
	for(var/atom/movable/moveable_atom in loc)
		if(iscarbon(moveable_atom))
			if(HAS_TRAIT(moveable_atom, TRAIT_WATER_SPONGE))
				var/mob/living/carbon/living = moveable_atom
				living.reagents.add_reagent(/datum/reagent/water, 3 * seconds_per_tick)

/obj/item/organ/lungs/proc/consume_water_vapor(mob/living/carbon/breather, datum/gas_mixture/breath, water_vapor_pp, old_water_vapor_pp)
	if(HAS_TRAIT(breather, TRAIT_WATER_SPONGE))
		if(breath)
			var/gas_breathed = breathe_gas_volume(breath, /datum/gas/water_vapor)
			if(gas_breathed > 0)
				breather.reagents.add_reagent(/datum/reagent/water, gas_breathed)

/datum/status_effect/fire_handler/wet_stacks/tick(seconds_between_ticks)
	if (stacks <= 0)
		return ..()
	
	if (HAS_TRAIT(owner, TRAIT_WATER_SPONGE))
		owner.reagents.add_reagent(/datum/reagent/water, 3 * seconds_between_ticks)

	return ..()

// /obj/machinery/pool/controller/process_reagents()
// 	for(var/turf/open/pool/W in linked_turfs)
// 		for(var/mob/living/carbon/human/swimee in W)
// 			if(HAS_TRAIT(swimee, TRAIT_WATER_SPONGE))
// 				swimee.reagents.add_reagent(/datum/reagent/water, 5)
// 	..()
