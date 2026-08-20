/// Adjusts the muscle mass of the parent mob.
/mob/living/carbon/proc/adjust_muscle(amount, ignore_rate = FALSE)
	if(!client?.prefs?.read_preference(/datum/preference/toggle/muscle_gain))
		return FALSE

	if(amount == 0)
		return FALSE

	var/muscle_to_change = amount
	if(!ignore_rate)
		if(muscle_to_change > 0)
			muscle_to_change *= muscle_gain_rate
		else
			muscle_to_change *= muscle_loss_rate

	muscle_real += amount
	muscle_real = max(muscle_real, 0)

	muscle = muscle_real
	// here is where fake muscle would go if we had it.
	return TRUE

/// Makes the parent lose weight and gain stamina damage based on intensity.
/mob/living/carbon/proc/work_out(intensity, custom_stamina_cost = null)
	if(!intensity)
		return FALSE

	if(get_stamina_loss() >= WORKOUT_STAMINA_THRESHOLD)
		to_chat(src, span_warning("You are too exhausted to continue!"))
		return FALSE

	var/stamina_cost = (intensity * INTENSITY_TO_STAMINA_RATIO)
	if(custom_stamina_cost != null)
		stamina_cost = custom_stamina_cost

	if(stamina_cost && !adjust_stamina_loss(stamina_cost))
		return FALSE

	// Alright, we have pain, now time for gain. How ripped are we getting from this?
	var/muscle_gained = intensity * INTENSITY_TO_MUSCLE_RATIO
	var/fatness_to_burn_through = (intensity * INTENSITY_TO_FAT_BURNED_RATIO) * weight_loss_rate
	if((fatness_to_burn_through < fatness_real) && adjust_fatness(-fatness_to_burn_through, FATTENING_TYPE_WEIGHT_LOSS)) // We have enough flab to burn.
		muscle_gained += fatness_to_burn_through // Add burned fat as extra muscle mass. It doesn't need to make sense if it's hot.

	adjust_muscle(muscle_gained)
	return TRUE
