#define ABOVE "Above"
#define BELOW "Below"
#define NO_CHECK "None"

/obj/machinery/door/airlock
	/// Fatness level to check
	var/fatness_to_check = 0
	/// Do we check if the person is fat/thin enough?
	var/check_fatness = FALSE
	/// Do we want the weight of the person opening the door to be below the set number?
	var/check_fatness_below = FALSE

/obj/machinery/door/airlock/proc/change_fatness_to_check(mob/user)
	var/selected_fatness = choose_weight(user, "What level of fatness do you wish to block the door at? Cancel to input the number manually.")
	if (selected_fatness <= 0)
		balloon_alert(user, "weight check reset")
		check_fatness = FALSE
		fatness_to_check = 0
		return

	var/above_below = tgui_input_list(
		user,
		"Do you wish to block the door when the weight is above or below the given weight?",
		"Above or below?",
		list(ABOVE, BELOW, NO_CHECK)
	)
	if (above_below == NO_CHECK)
		balloon_alert(user, "weight check reset")
		check_fatness = FALSE
		fatness_to_check = 0
		return
	
	fatness_to_check = selected_fatness
	check_fatness = TRUE
	check_fatness_below = above_below == BELOW
	balloon_alert(user, "weight check set")

// hack so we could keep the ACTUAL proc on `/obj/machinery/door/airlock`
/obj/machinery/door/proc/enough_fatness(mob/user)
	return TRUE

/**
 * Checks if the person trying to open the door has the right amount of fatness
 * 
 * Returns TRUE if the person has enough weight to let them through
 * 
 * Returns FALSE otherwise
 */
/obj/machinery/door/airlock/enough_fatness(mob/user)
	if (!check_fatness)
		return TRUE	// we don't check it, let them through

	var/mob/living/carbon/carbon_user = user
	if (!istype(carbon_user))
		return TRUE	// if they have no concept of fatness (blasphemous!), we let them through
	
	if (check_fatness_below)
		if (carbon_user.fatness >= fatness_to_check)
			return TRUE
			
		say("ERROR: WEIGHT TOO LOW!")
		return FALSE
	else
		if (carbon_user.fatness <= fatness_to_check)
			return TRUE
			
		say("ERROR: WEIGHT TOO HIGH!")
		return FALSE

/obj/machinery/door/airlock/multitool_act_secondary(mob/living/user, obj/item/tool)
	change_fatness_to_check(user)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/door/airlock/ui_data()
	. = ..()
	var/list/data = .

	data["weight_scan"] = check_fatness
	data["weight_scan_value"] = fatness_to_check
	data["weight_scan_above_below"] = check_fatness_below
	data["wires"]["weight_scan"] = !wires.is_cut(WIRE_WEIGHT_SCAN)
	return data

/obj/machinery/door/airlock/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!user_allowed(usr))
		return

	switch(action)
		if ("weight_scan-toggle")
			check_fatness = !check_fatness
		if ("set_weight_scan")
			change_fatness_to_check(usr)

#undef ABOVE
#undef BELOW
#undef NO_CHECK
