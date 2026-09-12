/// Water that applies an effect to people when the cross the water and while they are in the water.
/turf/open/water/effect
	/// What is the type of the mob we want to apply effects to?
	var/mob_type_to_apply_to = /mob/living
	/// Does the water apply a continous effect?
	var/continous_effect = FALSE

/// Applies an effect while the mob is within the liquid
/turf/open/water/effect/proc/apply_continous_effect(mob/living/target_mob)
	return can_mob_be_affected(target_mob)

/// Applies an effect  when the mob moves through the liquid
/turf/open/water/effect/proc/apply_movement_effect(mob/living/target_mob)
	return can_mob_be_affected(target_mob)

/// Can the checked mob be effected by the contents of this liquid?
/turf/open/water/effect/proc/can_mob_be_affected(mob/living/checked_mob)
	return istype(checked_mob, mob_type_to_apply_to)


/turf/open/water/effect/Entered(atom/movable/arrived)
	. = ..()
	if(!can_mob_be_affected(arrived))
		return

	apply_movement_effect(arrived)
	if(!continous_effect)
		return

	START_PROCESSING(SSobj, src)

/turf/open/water/effect/process(seconds_per_tick)
	var/has_mob_been_found = FALSE
	for(var/mob/living/mob_found in contents)
		if(!can_mob_be_affected(mob_found))
			continue

		has_mob_been_found = TRUE
		apply_continous_effect(mob_found)


	if(!has_mob_been_found)
		return PROCESS_KILL

/turf/open/water/effect/fattening
	mob_type_to_apply_to = /mob/living/carbon
	continous_effect = TRUE

	/// How much fatness is added while a mob moves?
	var/fatness_on_move = 0
	/// How much fatness is added while the mob is inside of the liquid?
	var/fatness_continously_added = 0
	/// How much perma fatness is added while a mob moves?
	var/perma_fatness_on_move = 0
	/// How much perma fatness is added while the mob is inside of the liquid?
	var/perma_fatness_continously_added = 0

/turf/open/water/effect/fattening/apply_movement_effect(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/target_carbon = target_mob
	if(fatness_on_move)
		target_carbon.adjust_fatness(fatness_on_move, FATTENING_TYPE_ITEM)
	if(perma_fatness_on_move)
		target_carbon.adjust_perma(perma_fatness_on_move, FATTENING_TYPE_ITEM)

	return TRUE

/turf/open/water/effect/fattening/apply_continous_effect(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/target_carbon = target_mob
	if(fatness_continously_added)
		target_carbon.adjust_fatness(fatness_continously_added, FATTENING_TYPE_ITEM)
	if(perma_fatness_continously_added)
		target_carbon.adjust_perma(perma_fatness_continously_added, FATTENING_TYPE_ITEM)

	return TRUE

/turf/open/water/effect/reagent
	mob_type_to_apply_to = /mob/living/carbon
	continous_effect = TRUE

	/// What kind of reagent is being added to the mob?
	var/reagent_type_being_added = /datum/reagent/consumable/sodawater
	/// How much fatness is added while a mob moves?
	var/reagent_volume_on_move = 0
	/// How much fatness is added while the mob is inside of the liquid?
	var/reagent_volume_continously_added = 0

/turf/open/water/effect/reagent/apply_movement_effect(mob/living/target_mob)
	. = ..()
	if(!. || !reagent_volume_on_move)
		return FALSE

	var/mob/living/carbon/target_carbon = target_mob
	target_carbon.reagents.add_reagent(reagent_type_being_added, reagent_volume_on_move)


/turf/open/water/effect/reagent/apply_continous_effect(mob/living/target_mob)
	. = ..()
	if(!. || !reagent_volume_continously_added)
		return FALSE

	var/mob/living/carbon/target_carbon = target_mob
	target_carbon.reagents.add_reagent(reagent_type_being_added, reagent_volume_continously_added)



