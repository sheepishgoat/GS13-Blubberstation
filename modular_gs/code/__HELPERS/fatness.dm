/// Prompts the user to select a level of weight.
/proc/choose_weight(mob/user, input_text = "Choose a weight.")
	var/chosen_weight = FALSE
	var/picked_weight_class = input(user,
		input_text,
		"Character Preference", "None") as null|anything in list(
			"None", "Rounded", "Fat", "Fatter", "Very Fat", "Obese", "Morbidly Obese", "Extremely Obese", "Barely Mobile", "Immobile", "Other")

	switch(picked_weight_class)
		if ("Rounded")
			chosen_weight = FATNESS_LEVEL_FAT
		if("Fat")
			chosen_weight = FATNESS_LEVEL_FATTER
		if("Fatter")
			chosen_weight = FATNESS_LEVEL_VERYFAT
		if("Very Fat")
			chosen_weight = FATNESS_LEVEL_OBESE
		if("Obese")
			chosen_weight = FATNESS_LEVEL_MORBIDLY_OBESE
		if("Morbidly Obese")
			chosen_weight = FATNESS_LEVEL_EXTREMELY_OBESE
		if("Extremely Obese")
			chosen_weight = FATNESS_LEVEL_BARELYMOBILE
		if("Barely Mobile")
			chosen_weight = FATNESS_LEVEL_IMMOBILE
		if("Immobile")
			chosen_weight = FATNESS_LEVEL_BLOB

	if(picked_weight_class != "Other")
		return chosen_weight

	var/custom_fatness = input(user, "What fatness level (BFI) would you like to use?", "Character Preference")  as null|num
	if(isnull(custom_fatness))
		custom_fatness = FALSE

	return custom_fatness

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
