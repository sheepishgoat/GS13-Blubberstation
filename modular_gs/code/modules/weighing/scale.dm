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
	/// Component responsible for scale behavior
	var/datum/component/weight_scale/scale_component

/obj/structure/scale/Initialize(mapload)
	. = ..()
	scale_component = AddComponent(/datum/component/weight_scale)

/obj/structure/scale/examine(mob/user)
	. = ..()
	. += span_notice("It's held together by a couple of <b>bolts</b>.")

/obj/structure/scale/wrench_act_secondary(mob/living/user, obj/item/tool)
	..()
	tool.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return TRUE

/obj/structure/scale/atom_deconstruct(disassembled)
	for(var/datum/material/mat as anything in custom_materials)
		new mat.sheet_type(loc, FLOOR(custom_materials[mat] / SHEET_MATERIAL_AMOUNT, 1))

/obj/structure/scale/Destroy(force)
	if(scale_component)
		QDEL_NULL(scale_component)

	return ..()

/obj/structure/scale/ui_interact(mob/user)
	scale_component.ui_interact(user)

/obj/structure/scale/breaking_scale
	/// weight **(IN POUNDS, NOT BFI!!!)** at which the scale breaks
	var/scale_breakage = 1000

/// makes it so code doesn't have to be reused
/obj/structure/scale/breaking_scale/proc/check_if_break(mob/living/carbon/fatty)
	if(!istype(fatty))
		return

	if(fatty.calculate_weight_in_pounds() > scale_breakage)
		playsound(loc, 'sound/effects/heavy_drop2.ogg', 50, TRUE)
		fatty.visible_message(
			span_notice("The scale shatters under the sheer weight of [fatty]!"),
			span_notice("As you step on the [src], it shatters, unable to hold your fatass!")
		)
		deconstruct()

/obj/structure/scale/breaking_scale/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(scale_break_check),
		COMSIG_ATOM_EXITED = PROC_REF(on_scale_leave),
	)
	AddComponent(/datum/component/connect_loc_behalf, src, loc_connections)

/obj/structure/scale/breaking_scale/examine(mob/user)
	. = ..()
	. += span_notice("It looks a bit flimsy")

/obj/structure/scale/breaking_scale/proc/scale_break_check(datum/source, mob/living/carbon/fatty)
	SIGNAL_HANDLER

	check_if_break(fatty)
	RegisterSignal(fatty, COMSIG_FATNESS_CHANGED, PROC_REF(standing_weight_changed))

/obj/structure/scale/breaking_scale/proc/on_scale_leave(datum/source, mob/living/carbon/fatty)
	SIGNAL_HANDLER
	if (!isnull(fatty))
		UnregisterSignal(fatty, COMSIG_FATNESS_CHANGED)

/obj/structure/scale/breaking_scale/proc/standing_weight_changed(mob/living/carbon/fatty, fatness)
	SIGNAL_HANDLER

	check_if_break(fatty)

///A larger, plasteel scale that doesn't break and takes up two tiles
/obj/structure/scale/plasteel
	name = "large scale"
	desc = "You can weigh yourself with this."
	icon = 'modular_gs/icons/obj/megascale.dmi'
	icon_state = "gato_industryscale"
	anchored = TRUE
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 25
	layer = OBJ_LAYER
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 3)
	/// Makes second tile of scale work
	var/obj/structure/scale/plasteel/right/partner

/obj/structure/scale/plasteel/Initialize(mapload)
	. = ..()
	// makes the right tile work
	if (!istype(src, /obj/structure/scale/plasteel/right))
		partner = new /obj/structure/scale/plasteel/right(get_step(src, EAST))
		partner.partner = src
		partner.scale_component.reassign_weighing_component(scale_component.weight_component)

/obj/structure/scale/plasteel/Destroy(force)
	. = ..()
	if (!istype(src, /obj/structure/scale/plasteel/right))
		QDEL_NULL(partner)

/// exists only to provide tile detection on the tile next to the scale
/obj/structure/scale/plasteel/right
	invisibility = INVISIBILITY_ABSTRACT

/obj/structure/scale/plasteel/examine(mob/user)
	. = ..()
	. += span_notice("It looks quite sturdy.")
