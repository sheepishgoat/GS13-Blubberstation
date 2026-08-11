/// Helper to get the amount of gassiness the mob's currently experiencing.
/mob/living/proc/get_gassy_amount()
	var/datum/status_effect/burpslurring/burpslur = has_status_effect(/datum/status_effect/burpslurring)
	return burpslur?.gassy_value || 0

/mob/living/carbon/get_fullness(only_consumable)
	. = ..()
	fullness = .	// old fullness
	return max(0, fullness + fullness_adjustment)

/// reduces the fullness amount that was adjusted from any external sources, as well as caps it to reasonable values
/mob/living/carbon/proc/fullness_adjustment()
	var/max_fullness_reduction = max(fullness + 500, 600)
	if(fullness_adjustment > 15)
		fullness_adjustment -= 15
	else if(fullness_adjustment < -15)
		fullness_adjustment += 15
	else
		fullness_adjustment = 0
	// You can either be reduced by max_fullness_reduction, or increased all the way to max fullness!
	fullness_adjustment = clamp(fullness_adjustment, -max_fullness_reduction, FULLNESS_MAX - fullness)

/// adjusts the mob hunger - essentially just reduces fullness. Calling this is preferred to doint it manually since it adjusts for the default hunger reduction rate
/mob/living/carbon/proc/adjust_hunger(amount)
	fullness_adjustment -= (15 + amount)

/mob/living/carbon/proc/handle_fullness_alert()
	switch(get_fullness())
		if(0 to FULLNESS_LEVEL_BLOATED)
			clear_alert("fullness")
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			throw_alert("fullness", /atom/movable/screen/alert/gs13/bloated)
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			throw_alert("fullness", /atom/movable/screen/alert/gs13/stuffed)
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			throw_alert("fullness", /atom/movable/screen/alert/gs13/beegbelly)
