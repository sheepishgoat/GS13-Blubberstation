/mob/living/carbon/proc/get_fullness_text()
	var/t_He = p_They()
	var/t_His = p_Their()

	switch(get_fullness())
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			return "[t_He] look[p_s()] like [t_He] ate a bit too much.\n"
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			return "[t_His] stomach looks very round and very full.\n"
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			return "[t_His] stomach has been stretched to enormous proportions.\n"

/mob/living/carbon/proc/get_weight_text()
	var/t_He = p_They()
	var/t_His = p_Their()
	var/t_is = p_are()
	var/ws_text

	if(fatness >= FATNESS_LEVEL_BLOB)
		ws_text = dna?.features["ws_fatty_blob"]
		if(ws_text)
			return ws_text

		return "[t_He] [t_is] completely engulfed in rolls upon rolls of flab. [t_His] head is poking out on top of [t_His] body, akin to a marble on top of a hill.\n"

	if(fatness >= FATNESS_LEVEL_IMMOBILE)
		ws_text = dna?.features["ws_immobile"]
		if(ws_text)
			return ws_text

		return "[t_His] body is buried in an overflowing surplus of adipose, and [t_His] legs are completely buried beneath layers of meaty, obese flesh.\n"

	if(fatness >= FATNESS_LEVEL_BARELYMOBILE)
		ws_text = dna?.features["ws_barely_mobile"]
		if(ws_text)
			return ws_text

		return "[t_He] [t_is] as wide as [t_He] [t_is] tall, barely able to move [t_His] masssive body that seems to be overtaken with piles of flab.\n"

	if(fatness >= FATNESS_LEVEL_EXTREMELY_OBESE)
		ws_text = dna?.features["ws_extremely_obese"]
		if(ws_text)
			return ws_text

		return "[t_He] [t_is] ripe with numerous rolls of fat, almost all of [t_His] body layered with adipose.\n"

	if(fatness >= FATNESS_LEVEL_MORBIDLY_OBESE)
		ws_text = dna?.features["ws_morbidly_obese"]
		if(ws_text)
			return ws_text

		return "[t_He] [t_is] utterly stuffed with abundant lard, [t_He] doesn't seem to be able to move much.\n"

	if(fatness >= FATNESS_LEVEL_OBESE)
		ws_text = dna?.features["ws_obese"]
		if(ws_text)
			return ws_text

		return "[t_He] [t_is] engorged with fat, [t_His] body laden in rolls of fattened flesh.\n"

	if(fatness >= FATNESS_LEVEL_VERYFAT)
		ws_text = dna?.features["ws_very_fat"]
		if(ws_text)
			return ws_text

		return "[t_He] [t_is] pleasantly plushy, [t_His] body gently wobbling whenever they move. \n"

	if(fatness >= FATNESS_LEVEL_FATTER)
		ws_text = dna?.features["ws_fat"]
		if(ws_text)
			return ws_text

		return "[t_He] [t_is] soft and curvy, [t_His] belly looking like a small pillow.\n"

	if(fatness >= FATNESS_LEVEL_FAT)
		ws_text = dna?.features["ws_rounded"]
		if(ws_text)
			return ws_text

	return

/mob/living/carbon/proc/get_muscle_text()
	/*
	var/t_He = p_They()
	var/t_His = p_Their()
	var/t_is = p_are()
	*/
	var/ws_text

	if(fatness >= FATNESS_LEVEL_BLOB)
		ws_text = dna?.features["ms_mountainous"]
		if(ws_text)
			return ws_text

		//return "[t_He] [t_is] completely engulfed in rolls upon rolls of flab. [t_His] head is poking out on top of [t_His] body, akin to a marble on top of a hill.\n"

	if(fatness >= FATNESS_LEVEL_IMMOBILE)
		ws_text = dna?.features["ms_titanic"]
		if(ws_text)
			return ws_text

		//return "[t_His] body is buried in an overflowing surplus of adipose, and [t_His] legs are completely buried beneath layers of meaty, obese flesh.\n"

	if(fatness >= FATNESS_LEVEL_BARELYMOBILE)
		ws_text = dna?.features["ms_hulking"]
		if(ws_text)
			return ws_text

		//return "[t_He] [t_is] as wide as [t_He] [t_is] tall, barely able to move [t_His] masssive body that seems to be overtaken with piles of flab.\n"

	if(fatness >= FATNESS_LEVEL_EXTREMELY_OBESE)
		ws_text = dna?.features["ms_herculean"]
		if(ws_text)
			return ws_text

		//return "[t_He] [t_is] ripe with numerous rolls of fat, almost all of [t_His] body layered with adipose.\n"

	if(fatness >= FATNESS_LEVEL_MORBIDLY_OBESE)
		ws_text = dna?.features["ms_beefy"]
		if(ws_text)
			return ws_text

		//return "[t_He] [t_is] utterly stuffed with abundant lard, [t_He] doesn't seem to be able to move much.\n"

	if(fatness >= FATNESS_LEVEL_OBESE)
		ws_text = dna?.features["ms_muscular"]
		if(ws_text)
			return ws_text

		//return "[t_He] [t_is] engorged with fat, [t_His] body laden in rolls of fattened flesh.\n"

	if(fatness >= FATNESS_LEVEL_VERYFAT)
		ws_text = dna?.features["ms_athletic"]
		if(ws_text)
			return ws_text

		//return "[t_He] [t_is] pleasantly plushy, [t_His] body gently wobbling whenever they move. \n"

	if(fatness >= FATNESS_LEVEL_FATTER)
		ws_text = dna?.features["ms_sporty"]
		if(ws_text)
			return ws_text

		//return "[t_He] [t_is] soft and curvy, [t_His] belly looking like a small pillow.\n"

	if(fatness >= FATNESS_LEVEL_FAT)
		ws_text = dna?.features["ms_toned"]
		if(ws_text)
			return ws_text

	return

