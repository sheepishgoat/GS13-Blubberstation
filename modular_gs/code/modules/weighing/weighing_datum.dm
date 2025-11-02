/**
 * # This datum collects, stores, and displays information about a mob's weight.
*/
/datum/component/weigh_out
	var/total_weight_pounds = 0
	var/total_weight = 0

	var/fatness_total_pounds = 0
	var/fatness_real_pounds = 0
	var/fatness_perma_pounds = 0
	var/fatness_other_pounds = 0

	var/fatness_total = 0
	var/fatness_real = 0
	var/fatness_perma = 0
	var/fatness_other = 0

	var/muscle_total_pounds = 0
	var/muscle_real_pounds = 0
	var/muscle_other_pounds = 0

	var/muscle_total = 0
	var/muscle_real = 0
	var/muscle_other = 0

	var/weight_gain_rate = 0
	var/weight_loss_rate = 0
	var/muscle_gain_rate = 0
	var/muscle_loss_rate = 0
	/// Who is the most recent person we've scanned?
	var/mob/living/carbon/most_recent_carbon
	/// Are we scanning someone?
	var/currently_weighing = FALSE


/// Generates a list containing category information. We mostly use this for TGUI
/datum/component/weigh_out/proc/generate_category_list()
	var/list/category_list = list()

	category_list["Fat"] = list(
		"Regular Fat" = list(fatness_real_pounds, fatness_real),
		"Long-Term Fat" = list(fatness_perma_pounds, fatness_perma),
		"Other Non-Muscle Mass" = list(fatness_other_pounds, fatness_other),
	)

	category_list["Muscle"] = list(
		"Regular Muscle" = list(muscle_real_pounds, muscle_real),
		"Other Muscle" = list(muscle_other_pounds, muscle_other),
	)

	return category_list

/// Updates the variables of the datum based on that of `target_mob`
/datum/component/weigh_out/proc/weigh(mob/living/carbon/target_mob)
	if(!istype(target_mob))
		return FALSE

	most_recent_carbon = target_mob
	total_weight_pounds = target_mob.calculate_weight_in_pounds()
	total_weight = (target_mob.fatness + target_mob.muscle)

	fatness_total = target_mob.fatness
	fatness_real = target_mob.fatness_real
	fatness_perma = target_mob.fatness_perma
	fatness_other = (fatness_total - (fatness_real + fatness_perma))

	fatness_total_pounds = target_mob.calculate_total_fatness_weight_in_pounds()
	fatness_real_pounds =  target_mob.calculate_fatness_weight_in_pounds(fatness_real)
	fatness_perma_pounds = target_mob.calculate_fatness_weight_in_pounds(fatness_perma)
	fatness_other_pounds = target_mob.calculate_fatness_weight_in_pounds(fatness_other)

	muscle_total = target_mob.muscle
	muscle_real = target_mob.muscle_real
	muscle_other = (muscle_total - muscle_real)

	muscle_total_pounds = target_mob.calculate_total_muscle_weight_in_pounds()
	muscle_real_pounds = target_mob.calculate_muscle_weight_in_pounds(muscle_real)
	muscle_other_pounds = target_mob.calculate_muscle_weight_in_pounds(muscle_other)

	weight_gain_rate = target_mob.weight_gain_rate
	weight_loss_rate = target_mob.weight_loss_rate
	muscle_gain_rate = target_mob.muscle_gain_rate
	muscle_loss_rate = target_mob.muscle_loss_rate

	return TRUE


/datum/component/weigh_out/ui_data(mob/user)
	var/list/data = list()
	data["currently_weighing"] = currently_weighing
	data["most_recent_carbon"] = most_recent_carbon

	var/able_to_weigh = (currently_weighing && istype(most_recent_carbon))
	data["able_to_weigh"] = able_to_weigh
	if(able_to_weigh)
		weigh(most_recent_carbon)

	data["total_weight"] = total_weight
	data["total_weight_pounds"] = total_weight_pounds
	data["total_fatness"] = fatness_total
	data["total_fatness_pounds"] = fatness_total_pounds
	data["total_muscle"] = muscle_total
	data["total_muscle_pounds"] = muscle_total_pounds

	data["wg_rate"] = "[weight_gain_rate * 100]%"
	data["wl_rate"] = "[weight_loss_rate * 100]%"
	data["mg_rate"] = "[muscle_gain_rate * 100]%"
	data["ml_rate"] = "[muscle_loss_rate * 100]%"

	data["weight_data"] = list()
	// Time for list bullshit :3
	var/list/weight_data = generate_category_list()
	for(var/category as anything in weight_data) // Go through all the different generated categories
		var/list/parsed_data_points = list()
		var/list/unparsed_data_points = weight_data[category]
		var/muscle_category = FALSE

		if(findtext(category, "Muscle"))
			muscle_category = TRUE


		for(var/data_point as anything in unparsed_data_points) // Parse a data point and add it to parsed_data_points
			var/data_point_as_list = list(
				"name" = data_point,
				"pounds" = unparsed_data_points[data_point][1],
				"value" = unparsed_data_points[data_point][2],
			)
			parsed_data_points += list(data_point_as_list)

		var/category_data = list(
			"name" = category,
			"data_points" = parsed_data_points,
			"muscle_category" = muscle_category,
		)
		data["weight_data"] += list(category_data)

	return data

/datum/component/weigh_out/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScalePanel", src)
		ui.open()

/datum/component/weigh_out/ui_state(mob/user)
	return GLOB.default_state
