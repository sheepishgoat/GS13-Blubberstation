/mob/living/carbon/proc/get_fullness_text()
	switch(get_fullness())
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			return "[p_They()] look[p_s()] like [p_they()] ate a bit too much.\n"
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			return "[p_Their()] stomach looks very round and very full.\n"
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			return "[p_Their()] stomach has been stretched to enormous proportions.\n"

/mob/living/carbon/proc/get_weight_text()
	var/ws_text

	if(fatness >= FATNESS_LEVEL_BLOB)
		ws_text = dna?.features["ws_fatty_blob"]
		if(ws_text)
			return ws_text

		return "[p_They()] [p_are()] completely engulfed in rolls upon rolls of flab. [p_Their()] head is poking out on top of [p_their()] body, akin to a marble on top of a hill.\n"

	if(fatness >= FATNESS_LEVEL_IMMOBILE)
		ws_text = dna?.features["ws_immobile"]
		if(ws_text)
			return ws_text

		return "[p_Their()] body is buried in an overflowing surplus of adipose, and [p_their()] legs are completely buried beneath layers of meaty, obese flesh.\n"

	if(fatness >= FATNESS_LEVEL_BARELYMOBILE)
		ws_text = dna?.features["ws_barely_mobile"]
		if(ws_text)
			return ws_text

		return "[p_They()] [p_are()] as wide as [p_they()] [p_are()] tall, barely able to move [p_their()] massive body that seems to be overtaken with piles of flab.\n"

	if(fatness >= FATNESS_LEVEL_EXTREMELY_OBESE)
		ws_text = dna?.features["ws_extremely_obese"]
		if(ws_text)
			return ws_text

		return "[p_They()] [p_are()] ripe with numerous rolls of fat, almost all of [p_their()] body layered with adipose.\n"

	if(fatness >= FATNESS_LEVEL_MORBIDLY_OBESE)
		ws_text = dna?.features["ws_morbidly_obese"]
		if(ws_text)
			return ws_text

		return "[p_They()] [p_are()] utterly stuffed with abundant lard, [p_they()] [p_do()]n't seem to be able to move much.\n"

	if(fatness >= FATNESS_LEVEL_OBESE)
		ws_text = dna?.features["ws_obese"]
		if(ws_text)
			return ws_text

		return "[p_They()] [p_are()] engorged with fat, [p_their()] body laden in rolls of fattened flesh.\n"

	if(fatness >= FATNESS_LEVEL_VERYFAT)
		ws_text = dna?.features["ws_very_fat"]
		if(ws_text)
			return ws_text

		return "[p_They()] [p_are()] pleasantly plushy, [p_their()] body gently wobbling whenever they move. \n"

	if(fatness >= FATNESS_LEVEL_FATTER)
		ws_text = dna?.features["ws_fat"]
		if(ws_text)
			return ws_text

		return "[p_They()] [p_are()] soft and curvy, [p_their()] belly looking like a small pillow.\n"

	if(fatness >= FATNESS_LEVEL_FAT)
		ws_text = dna?.features["ws_rounded"]
		if(ws_text)
			return ws_text

	return

/mob/living/carbon/proc/get_muscle_text()
	var/ws_text

	if(muscle >= FATNESS_LEVEL_BLOB)
		ws_text = dna?.features["ms_mountainous"]
		if(ws_text)
			return ws_text

		return "[p_They()] has become nothing but a grotesque mound of terrifying strength and uncontrollable might.\n"

	if(muscle >= FATNESS_LEVEL_IMMOBILE)
		ws_text = dna?.features["ms_titanic"]
		if(ws_text)
			return ws_text

		return "[p_They()] body totally eclipses any trace of [p_their()] head, shrouded from every direction by the muscles that dominate every part of [p_them()].\n"

	if(muscle >= FATNESS_LEVEL_BARELYMOBILE)
		ws_text = dna?.features["ms_hulking"]
		if(ws_text)
			return ws_text

		return "[p_They()] has begun to lose [p_their()] form, muscles without any space flooding out from where they've been growing; presumably for quite a while.\n"

	if(muscle >= FATNESS_LEVEL_EXTREMELY_OBESE)
		ws_text = dna?.features["ms_herculean"]
		if(ws_text)
			return ws_text
		
		return "\"Bodybuilder\" is a term that understates just how big [p_they()] [p_are()], possessing a body that people could only typically achieve through the use of performance enhancers."

	if(muscle >= FATNESS_LEVEL_MORBIDLY_OBESE)
		ws_text = dna?.features["ms_beefy"]
		if(ws_text)
			return ws_text

		return "It would be very easy to mistake [p_them()] for a professional bodybuilder, every inch bursting with bulk.\n"

	if(muscle >= FATNESS_LEVEL_OBESE)
		ws_text = dna?.features["ms_muscular"]
		if(ws_text)
			return ws_text

		return "[p_They()] looks as if [p_they()] has become accustomed to a much more active life than their peers, seeming no stranger to the bench press.\n"

	if(muscle >= FATNESS_LEVEL_VERYFAT)
		ws_text = dna?.features["ms_athletic"]
		if(ws_text)
			return ws_text

		return "[p_Their()] limbs have grown with a new layer of muscle, [p_their()] time in the gym looking like it's starting to pay off.\n"

	if(muscle >= FATNESS_LEVEL_FATTER)
		ws_text = dna?.features["ms_sporty"]
		if(ws_text)
			return ws_text

		return "[p_They()] seems a bit stronger than usual.\n"

	if(muscle >= FATNESS_LEVEL_FAT)
		ws_text = dna?.features["ms_toned"]
		if(ws_text)
			return ws_text

	return

