/obj/machinery/fan //Due to constrains, atmos effects arent stopped on depower, so only the self powered version is player buildable. Ported from Novasector.
	name = "tiny fan"
	desc = "A tiny fan, releasing a thin gust of air."
	layer = HIGH_PIPE_LAYER
	power_channel = AREA_USAGE_ENVIRON
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION
	use_power = IDLE_POWER_USE
	max_integrity = 150
	density = FALSE
	icon = 'icons/obj/mining_zones/survival_pod.dmi'
	icon_state = "fan_tiny"
	can_atmos_pass = ATMOS_PASS_NO
	rad_insulation = RAD_LIGHT_INSULATION
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

/obj/machinery/fan/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE, TRUE)

/obj/machinery/fan/Destroy()
	air_update_turf(TRUE, FALSE)
	. = ..()

/obj/machinery/fan/self_powered/on_deconstruction(disassembled)
	new /obj/item/stack/sheet/plasteel(drop_location(), 4)
	new /obj/item/stack/cable_coil/five(drop_location())

/obj/machinery/fan/block_superconductivity()
	if (machine_stat & (BROKEN|NOPOWER))
		return FALSE
	return TRUE

/obj/machinery/fan/wrench_act(mob/living/user, obj/item/tool)
	loc.balloon_alert_to_viewers("deconstructing...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 50))
		return ITEM_INTERACT_BLOCKING
	loc.balloon_alert_to_viewers("deconstructed!")
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/fan/self_powered
	name = "self-powered tiny fan"
	desc = parent_type::desc + " This one seems to have a heated plasma shard that propels the blades!"
	use_power = NO_POWER_USE
	custom_materials = list(
		/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.05,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/machinery/fan/self_powered/on_deconstruction(disassembled)
	. = ..()
	new /obj/item/stack/sheet/mineral/plasma(drop_location())

/datum/crafting_recipe/tiny_fan
	name = "Self-Powered Tiny Fan"
	tool_behaviors = list(TOOL_WRENCH, TOOL_WELDER)
	result = /obj/machinery/fan/self_powered
	reqs = list(
		/obj/item/pipe = 1,
		/obj/item/stack/sheet/plasteel = 4,
		/obj/item/stack/cable_coil = 5,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	time = 2 SECONDS
	category = CAT_ATMOSPHERIC
