/obj/structure/scale
	name = "weighing scale"
	desc = "You can weigh yourself with this."
	icon = 'modular_gs/icons/obj/scale.dmi'
	icon_state = "scale"
	anchored = TRUE
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 25
	layer = OBJ_LAYER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)
	//stores the weight of the last person to step on in Lbs
	var/last_reading = 0
	/// What datum are we using to track weight?
	var/datum/component/weigh_out/weight_component
	/// the mob currently being weighted
	var/mob/living/carbon/weightee

/obj/structure/scale/wrench_act_secondary(mob/living/user, obj/item/tool)
	..()
	tool.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return TRUE

/obj/structure/scale/atom_deconstruct(disassembled)
	for(var/datum/material/mat as anything in custom_materials)
		new mat.sheet_type(loc, FLOOR(custom_materials[mat] / SHEET_MATERIAL_AMOUNT, 1))

/obj/structure/scale/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(weighperson),
		COMSIG_ATOM_EXITED = PROC_REF(check_weightees),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	weight_component = AddComponent(/datum/component/weigh_out)

/obj/structure/scale/Destroy(force)
	if(weight_component)
		qdel(weight_component)

	return ..()

/obj/structure/scale/examine(mob/user)
	. = ..()
	. += "Its last reading was: [last_reading]Lbs"
	. += span_notice("It's held together by a couple of <b>bolts</b>.")

/obj/structure/scale/proc/weighEffect(mob/living/carbon/human/fatty)
	to_chat(fatty, span_notice("You weigh yourself."))
	to_chat(fatty, span_notice("The numbers on the screen tick up and eventually settle on:"))
	//The appearance of the numbers changes with the fat level of the character
	if (HAS_TRAIT(fatty, TRAIT_BLOB))
		to_chat(fatty, span_userdanger(span_big("[round(last_reading/2000, 0.01)]TONS!!!")))

	else if (HAS_TRAIT(fatty, TRAIT_IMMOBILE))
		to_chat(fatty, span_bolddanger("[last_reading]Lbs!"))

	else if(HAS_TRAIT(fatty, TRAIT_OBESE) || HAS_TRAIT(fatty, TRAIT_MORBIDLYOBESE))
		to_chat(fatty, span_alert("[last_reading]Lbs!"))

	else
		to_chat(fatty, span_notice("[last_reading]Lbs."))

/obj/structure/scale/proc/weighperson(datum/source, mob/living/carbon/fatty)
	SIGNAL_HANDLER
	if(!istype(fatty) || (fatty.movement_type & FLYING))
		return FALSE

	last_reading = fatty.calculate_weight_in_pounds()
	weighEffect(fatty)
	visible_message(span_notice("[fatty] weighs themselves."))
	visible_message(span_notice("The numbers on the screen settle on: [last_reading]Lbs."))
	visible_message(span_notice("The numbers on the screen read out: [fatty] has a BFI of [fatty.fatness]."))

	if (!isnull(weightee))
		UnregisterSignal(weightee, COMSIG_FATNESS_CHANGED)
	weightee = fatty
	RegisterSignal(fatty, COMSIG_FATNESS_CHANGED, PROC_REF(update_last_reading))

	weight_component.weigh(fatty)
	weight_component.currently_weighing = TRUE
	weight_component.most_recent_carbon = fatty

/// called when an object leaves the scales tile. checks if there are any other valid carbons on the tile and starts weighting them instead
/obj/structure/scale/proc/check_weightees(datum/source)
	SIGNAL_HANDLER
	if (!isnull(weightee))
		UnregisterSignal(weightee, COMSIG_FATNESS_CHANGED)
	for (var/mob/living/carbon/potential_fatty as anything in loc)
		if (istype(potential_fatty, /mob/living/carbon) && !(potential_fatty.movement_type & FLYING))
			weighperson(source, potential_fatty)
			return

	weightee = null
	weight_component.currently_weighing = FALSE

/obj/structure/scale/proc/update_last_reading(mob/living/carbon/fatty, fatness)
	SIGNAL_HANDLER
	last_reading = fatty.calculate_weight_in_pounds()

/obj/structure/scale/ui_interact(mob/user)
	weight_component.ui_interact(user)
