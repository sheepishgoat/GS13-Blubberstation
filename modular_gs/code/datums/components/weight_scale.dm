/datum/component/weight_scale
	//stores the weight of the last person to step on in Lbs
	var/last_reading = 0
	/// Datum used to track weight
	var/datum/component/weigh_out/weight_component
	/// the mob currently being weighted
	var/mob/living/carbon/weightee

/datum/component/weight_scale/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_mob_enter),
		COMSIG_ATOM_EXITED = PROC_REF(on_mob_leave),
	)
	AddComponent(/datum/component/connect_loc_behalf, parent, loc_connections)
	weight_component = AddComponent(/datum/component/weigh_out)
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(get_last_reading))

/datum/component/weight_scale/Destroy(force)
	if(weight_component)
		QDEL_NULL(weight_component)

	return ..()

/datum/component/weight_scale/proc/get_last_reading(obj/item/source, mob/examiner, list/examine_list)
	examine_list += "Its last reading was: [last_reading]Lbs"

/datum/component/weight_scale/proc/on_mob_enter(datum/source, mob/living/carbon/fatty)
	SIGNAL_HANDLER
	if(!istype(fatty) || (fatty.movement_type & FLYING))
		return FALSE

	last_reading = fatty.calculate_weight_in_pounds()
	fatty.visible_message(
		span_notice("[fatty] weighs themselves."),
		span_notice("You weigh yourself.")
		)
	fatty.visible_message(
		span_notice("The numbers on the screen tick up and eventually settle on: [last_reading]Lbs, with a BFI of [fatty.fatness]"),
		generate_weightee_flavor(fatty.fatness)
		)

	if (!isnull(weightee))
		UnregisterSignal(weightee, COMSIG_FATNESS_CHANGED)
	weightee = fatty
	RegisterSignal(fatty, COMSIG_FATNESS_CHANGED, PROC_REF(update_last_reading))

	weight_component.weigh(fatty)
	weight_component.currently_weighing = TRUE
	weight_component.most_recent_carbon = fatty

/// returns the flavor message to give to the player
/datum/component/weight_scale/proc/generate_weightee_flavor(fatness)
	var/message = span_notice("The numbers on the screen tick up and eventually settle on:\n")
	switch (fatness)
		if (0 to FATNESS_LEVEL_OBESE)
			message += span_notice("[last_reading]Lbs.")
		if (FATNESS_LEVEL_OBESE to FATNESS_LEVEL_EXTREMELY_OBESE)
			message += span_alert("[last_reading]Lbs!")
		if (FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_BLOB)
			message += span_bolddanger("[last_reading]Lbs!")
		if (FATNESS_LEVEL_BLOB to INFINITY)
			var/tons = round(last_reading/2000, 0.01)
			if (tons < 0.5)
				message += span_userdanger(span_big("[last_reading]Lbs!!!"))
			else
				message += span_userdanger(span_big("[round(last_reading/2000, 0.01)]TONS!!!"))
	
	return message

/datum/component/weight_scale/heft_scale/generate_weightee_flavor(fatness)
	var/obj/machinery/heft_scale/scale = parent
	if (!istype(scale))
		return ..()

	scale.generate_weight_response(fatness)

	return ..()

/datum/component/weight_scale/proc/on_mob_leave(datum/source)
	SIGNAL_HANDLER
	if (!isnull(weightee))
		UnregisterSignal(weightee, COMSIG_FATNESS_CHANGED)

	var/atom/our_parent = parent
	for (var/mob/living/carbon/potential_fatty as anything in our_parent.loc)
		if (istype(potential_fatty, /mob/living/carbon) && !(potential_fatty.movement_type & FLYING))
			on_mob_enter(source, potential_fatty)
			return

	weightee = null
	weight_component.currently_weighing = FALSE

/datum/component/weight_scale/proc/update_last_reading(mob/living/carbon/fatty, fatness)
	SIGNAL_HANDLER
	last_reading = fatty.calculate_weight_in_pounds()

/datum/component/weight_scale/ui_data(mob/user)
	return weight_component.ui_data(user)

/datum/component/weight_scale/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScalePanel", src)
		ui.open()
