/// Prompts the user to select a level of weight.
/proc/choose_weight(mob/user, input_text = "Choose a weight. Cancel to input the number manually.")
	var/picked_weight = tgui_input_list(
		user,
		input_text,
		"Choose a weight.",
		GLOB.fatness_stage_to_BFI_labeled
	)

	if(!isnull(picked_weight))
		return GLOB.fatness_stage_to_BFI_labeled[picked_weight]

	picked_weight = tgui_input_number(user, "Input the desired BFI value", "Choose a weight", max_value = INFINITY)
	if(isnull(picked_weight))
		picked_weight = 0

	return picked_weight

/// Returns the amount of fatness it would take to get to the next fatness stage
/proc/get_weight_delta_positive(input_fatness)
	switch(input_fatness)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			return 0 // We are already peak.

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			return (FATNESS_LEVEL_BLOB - input_fatness)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			return (FATNESS_LEVEL_IMMOBILE - input_fatness)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			return (FATNESS_LEVEL_BARELYMOBILE - input_fatness)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			return (FATNESS_LEVEL_EXTREMELY_OBESE - input_fatness)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			return (FATNESS_LEVEL_MORBIDLY_OBESE - input_fatness)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			return (FATNESS_LEVEL_OBESE - input_fatness)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			return (FATNESS_LEVEL_VERYFAT - input_fatness)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			return (FATNESS_LEVEL_FATTER - input_fatness)

	return FATNESS_LEVEL_FAT - input_fatness

/// Returns the amount of fatness it would take to get down to the previous fatness stage
/proc/get_weight_delta_negative(input_fatness)
	switch(input_fatness)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			return input_fatness - FATNESS_LEVEL_BLOB // We are already peak.

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			return (input_fatness - FATNESS_LEVEL_IMMOBILE)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			return (input_fatness - FATNESS_LEVEL_BARELYMOBILE)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			return (input_fatness - FATNESS_LEVEL_EXTREMELY_OBESE)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			return (input_fatness - FATNESS_LEVEL_MORBIDLY_OBESE)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			return (input_fatness - FATNESS_LEVEL_OBESE)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			return (input_fatness - FATNESS_LEVEL_VERYFAT)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			return (input_fatness - FATNESS_LEVEL_FATTER)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			return (input_fatness - FATNESS_LEVEL_FAT)

	return input_fatness
