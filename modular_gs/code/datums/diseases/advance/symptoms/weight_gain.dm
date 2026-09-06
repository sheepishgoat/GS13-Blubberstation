/datum/symptom/weight_gain
	name = "Weight Gain"
	desc = "The virus mutates and merges itself with the host's adipocytes, allowing them to perform a form of mitosis and replicate on their own."
	stealth = -3
	resistance = -2
	stage_speed = 3
	transmittable = -2
	level = 6
	severity = 3
	base_message_chance = 10
	// don't delay it so calcs are easy
	symptom_delay_min = 0
	symptom_delay_max = 0
	threshold_descs = list(
		"Stage Speed 7" = "Increases the rate of cell replication.",
		"Stage Speed 12" = "Increases the rate of cell replication further"
	)

/datum/symptom/weight_gain/Activate(datum/disease/advance/advanced_disease)
	if(!..())
		return
	var/mob/living/carbon/host = advanced_disease.affected_mob
	if(!(host?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_viruses)))
		return FALSE
	switch(advanced_disease.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(host, "<span class='warning'>[pick("You feel oddly full...", "You feel more plush...", "You feel more huggable...", "You hear an odd gurgle from your stomach")]</span>")
		else
			to_chat(host, "<span class='warning'><i>[pick("You feel your body churn...", "You feel heavier...", "You hear an ominous gurgle from your belly...", "You feel bulkier...")]</i></span>")
			if(advanced_disease.totalStageSpeed() >= 12) //get chunkier quicker
				host.adjust_fatness(10, FATTENING_TYPE_VIRUS)
			else if(advanced_disease.totalStageSpeed() >= 7)
				host.adjust_fatness(4, FATTENING_TYPE_VIRUS)
			else
				host.adjust_fatness(2, FATTENING_TYPE_VIRUS)
