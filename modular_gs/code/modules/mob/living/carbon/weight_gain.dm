/// Handles weight gain from digesting food/stomach contents
/mob/living/carbon/proc/handle_weight_gain()
	calculate_fatness()

	handle_fatness()
	fullness_adjustment()
	handle_helplessness()
	handle_modular_items()

	if (handle_bursting()) //We want to skip the rest if we exploded
		return

	/*
	var/obj/item/organ/genital/external/belly/B = getorganslot("belly")
	if(!isnull(B) && istype(B))
		B.update()
	*/

	switch(fatness)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/blob)

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/immobile)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/barelymobile)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/extremelyobese)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/morbidlyobese)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/obese)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/veryfat)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/fatter)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			throw_alert("fatness", /atom/movable/screen/alert/gs13/fat)

		if(0 to FATNESS_LEVEL_FAT)
			clear_alert("fatness")

	switch(muscle)
		if(FATNESS_LEVEL_BLOB to INFINITY)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/mountainous)

		if(FATNESS_LEVEL_IMMOBILE to FATNESS_LEVEL_BLOB)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/titanic)

		if(FATNESS_LEVEL_BARELYMOBILE to FATNESS_LEVEL_IMMOBILE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/hulking)

		if(FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BARELYMOBILE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/herculean)

		if(FATNESS_LEVEL_MORBIDLY_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/beefy)

		if(FATNESS_LEVEL_OBESE to FATNESS_LEVEL_MORBIDLY_OBESE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/muscular)

		if(FATNESS_LEVEL_VERYFAT to FATNESS_LEVEL_OBESE)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/athletic)

		if(FATNESS_LEVEL_FATTER to FATNESS_LEVEL_VERYFAT)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/sporty)

		if(FATNESS_LEVEL_FAT to FATNESS_LEVEL_FATTER)
			throw_alert("muscle", /atom/movable/screen/alert/gs13/toned)

		if(0 to FATNESS_LEVEL_FAT)
			clear_alert("muscle")

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
