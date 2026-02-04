/obj/machinery/gs/fan/ //Buildable tiny fan! Just a self powered variant for now, apc powered version in the future? Who knows.
	name = "tiny fan"
	desc = "A tiny fan, releasing a thin gust of air."
	layer = HIGH_PIPE_LAYER
	use_power = NO_POWER_USE
	max_integrity = 150
	density = FALSE
	icon = 'icons/obj/mining_zones/survival_pod.dmi'
	icon_state = "fan_tiny"
	can_atmos_pass = ATMOS_PASS_NO
	rad_insulation = RAD_LIGHT_INSULATION
	resistance_flags = FIRE_PROOF | FREEZE_PROOF
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.05, /datum/material/plasma = SHEET_MATERIAL_AMOUNT)

/obj/machinery/gs/fan/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE, TRUE)

/obj/machinery/gs/fan/Destroy()
	air_update_turf(TRUE, FALSE)
	return ..()

/obj/machinery/gs/fan/on_deconstruction(disassembled)
	new /obj/item/stack/sheet/iron(drop_location(), 5)
	new /obj/item/stack/cable_coil/five(drop_location())
	new /obj/item/stack/sheet/mineral/plasma(drop_location())

/obj/machinery/gs/fan/block_superconductivity()
	return TRUE

/obj/machinery/gs/fan/wrench_act(mob/living/user, obj/item/tool)
	loc.balloon_alert_to_viewers("deconstructing...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 50))
		return ITEM_INTERACT_BLOCKING
	loc.balloon_alert_to_viewers("deconstructed!")
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/datum/crafting_recipe/gs/fan
	name = "Tiny Fan"
	tool_behaviors = list(TOOL_WRENCH, TOOL_WELDER)
	result = /obj/machinery/gs/fan/
	reqs = list(
		/obj/item/pipe = 1,
		/obj/item/stack/sheet/iron = 4,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	time = 2 SECONDS
	category = CAT_ATMOSPHERIC
