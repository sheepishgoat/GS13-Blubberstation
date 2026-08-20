/proc/healthscan_bfi_info(mob/living/carbon/target, scanpower)
	var/list/render_list = list()
	var/micro_calorite_poisoning = target.micro_calorite_poisoning

	render_list += span_info("Subject weighs [target.calculate_weight_in_pounds()] pounds ([target.fatness] BFI).<br>")

	var/substance_identity_string = "anomalous substances"
	if (scanpower >= SCANPOWER_ADVANCED)
		substance_identity_string = "calorite"

	if(micro_calorite_poisoning >= 50)
		render_list += span_danger("WARNING! Large amounts of [substance_identity_string] detected in subject!<br>")
	else if(micro_calorite_poisoning >= 30)
		render_list += span_warning("Warning! Significant amounts of [substance_identity_string] detected in subject!<br>")
	else if (micro_calorite_poisoning >= 10)
		render_list += span_info("Small amounts of [substance_identity_string] detected in subject.<br>")

	if (scanpower == SCANPOWER_ADVANCED && micro_calorite_poisoning >= 10)
		render_list += span_info("Poisoning progress: [round(micro_calorite_poisoning, 0.01)]%.<br>")
	else if (scanpower == SCANPOWER_SUPER)
		render_list += span_info("Poisoning progress: [round(micro_calorite_poisoning, 0.01)]%.<br>")
	
	return render_list
