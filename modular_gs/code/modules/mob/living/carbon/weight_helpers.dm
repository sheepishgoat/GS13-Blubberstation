/// Calculates how much fatness_to_calculate would be in pounds.
/mob/living/carbon/proc/calculate_fatness_weight_in_pounds(fatness_to_calculate)
	return round(((fatness_to_calculate*FATNESS_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))

/// Returns the weight of all of the mob's fatness in pounds.
/mob/living/carbon/proc/calculate_total_fatness_weight_in_pounds()
	return round(((fatness*FATNESS_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))	// huff, being bigger really does raise the number on that scale by quite a bit huh~?
	//return round((140 + (fatness*FATNESS_TO_WEIGHT_RATIO))*(size_multiplier**2)*((dna.features["taur"] != "None") ? 2.5: 1))

/// Calculates how much muscle_to_calculate would be in pounds.
/mob/living/carbon/proc/calculate_muscle_weight_in_pounds(muscle_to_calculate)
	return round(((muscle_to_calculate*MUSCLE_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))

/// Returns the weight of all of the mob's muscles in pounds.
/mob/living/carbon/proc/calculate_total_muscle_weight_in_pounds()
	return round(((muscle*MUSCLE_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))

/mob/living/carbon/proc/calculate_weight_in_pounds()
	return calculate_total_fatness_weight_in_pounds() + calculate_total_muscle_weight_in_pounds() + (BASE_WEIGHT_VALUE * (dna.current_body_size ** 2))

