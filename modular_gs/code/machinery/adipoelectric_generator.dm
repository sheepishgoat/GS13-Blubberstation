#define KILO_WATT *1000
#define MEGA_WATT *1000000
/// base amount of power in Watts gained from one BFI
#define WATTS_PER_BFI 10 KILO_WATT

/obj/machinery/power/adipoelectric_generator
	name = "adipoelectric generator"
	desc = "This device uses calorite technology to transform excess blubber into power!"
	icon = 'modular_gs/icons/obj/adipoelectric_transformer.dmi'
	icon_state = "state_off"
	density = FALSE
	anchored = FALSE
	use_power = NO_POWER_USE
	state_open = TRUE
	circuit = /obj/item/circuitboard/machine/power/adipoelectric_generator
	occupant_typecache = list(/mob/living/carbon)
	/// multiplier to power gained from BFI
	var/laser_modifier = 0
	/// maximum BFI we can take per second
	var/max_fat = 0
	var/emp_timer = 0
	var/active = FALSE

// for mapping
/obj/machinery/power/adipoelectric_generator/anchored
	anchored = TRUE

/obj/machinery/power/adipoelectric_generator/Initialize(mapload)
	. = ..()
	if(anchored)
		connect_to_network()
	update_icon()

/obj/machinery/power/adipoelectric_generator/RefreshParts()
	..()
	laser_modifier = 0
	max_fat = 0
	for(var/datum/stock_part/micro_laser/laser in component_parts)
		laser_modifier += laser.tier
	for(var/datum/stock_part/matter_bin/matter_bin in component_parts)
		max_fat += matter_bin.tier * 5

/obj/machinery/power/adipoelectric_generator/process(seconds_per_tick)
	if(!is_operational)
		return

	var/mob/living/carbon/carbon = occupant

	if(isnull(carbon) || !istype(carbon))
		visible_message(span_alert("The [src] buzzes. It needs someone standing on it to work."))
		playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50)
		active = FALSE
		return PROCESS_KILL

	if(carbon.fatness_real > 0 && powernet && anchored && (emp_timer < world.time))
		active = TRUE
		var/fat_burned = abs(carbon.adjust_fatness(-(max_fat * seconds_per_tick), FATTENING_TYPE_ITEM, TRUE))
		add_avail(WATTS_PER_BFI * laser_modifier * fat_burned)
	else
		active = FALSE
	update_icon()

/obj/machinery/power/adipoelectric_generator/relaymove(mob/user)
	if(user.stat)
		return
	open_machine()

/obj/machinery/power/adipoelectric_generator/emp_act(severity)
	. = ..()
	if(!(machine_stat & (BROKEN|NOPOWER)))
		emp_timer = world.time + 600
		if(occupant)
			src.visible_message("<span class='alert'>The [src] buzzes and expels anyone inside!.</span>")
			open_machine()

/obj/machinery/power/adipoelectric_generator/can_be_unfasten_wrench(mob/user, silent)
	if(!state_open)
		to_chat(user, span_warning("Turn \the [src] off first!"))
		return FAILED_UNFASTEN

	return ..()

/obj/machinery/power/adipoelectric_generator/wrench_act(mob/living/user, obj/item/tool)
	default_unfasten_wrench(user, tool)
	if (anchored)
		connect_to_network()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/adipoelectric_generator/crowbar_act(mob/living/user, obj/item/tool)
	default_deconstruction_crowbar(tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/adipoelectric_generator/screwdriver_act(mob/living/user, obj/item/item)
	if(!state_open)
		return ITEM_INTERACT_BLOCKING
	default_deconstruction_screwdriver(user, "state_open", "state_off", item)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/adipoelectric_generator/interact(mob/user)
	toggle_open()
	return TRUE

/obj/machinery/power/adipoelectric_generator/proc/toggle_open()
	if(state_open)
		close_machine()
	else
		open_machine()
	update_icon()

/obj/machinery/power/adipoelectric_generator/open_machine(drop = TRUE, density_to_set = FALSE)
	. = ..()
	active = FALSE
	STOP_PROCESSING(SSobj, src)

/obj/machinery/power/adipoelectric_generator/close_machine(atom/movable/target, density_to_set = TRUE)
	. = ..()
	if(!occupant)
		src.visible_message(span_alert("[src] needs to have an occupant to work."))
		open_machine()
		return

	if(!anchored)
		src.visible_message(span_alert("[src] needs to be anchored to the floor."))
		open_machine()
		return

	if(panel_open)
		src.visible_message(span_alert("[src] needs to have it's panel closed."))
		open_machine()
		return

	add_fingerprint(occupant)
	START_PROCESSING(SSobj, src)

/obj/machinery/power/adipoelectric_generator/update_icon()
	. = ..()
	cut_overlays()
	if(panel_open)
		icon_state = "state_open"
		return
	if(occupant)
		var/image/occupant_overlay
		occupant_overlay = image(occupant.icon, occupant.icon_state)
		occupant_overlay.copy_overlays(occupant)
		occupant_overlay.dir = SOUTH
		occupant_overlay.pixel_y = 10
		add_overlay(occupant_overlay)
		if(!active)
			icon_state = "state_off"
		else
			icon_state = "state_on"
	else
		icon_state = "state_off"

/obj/machinery/power/adipoelectric_generator/power_change()
	..()
	update_icon()

/obj/machinery/power/adipoelectric_generator/examine(mob/user)
	. = ..()
	if(is_operational)
		. += "<span class='notice'>[src]'s show it can produce <b>[WATTS_PER_BFI * laser_modifier]W</b> per adipose unit, taking in <b>[max_fat]</b> max each second.</span>"
	else
		. += "<span class='notice'><b>[src]'s display is currently offline.</b></span>"

/obj/item/circuitboard/machine/power/adipoelectric_generator
	name = "Adipoelectric Generator"
	build_path = /obj/machinery/power/adipoelectric_generator
	req_components = list(
		/datum/stock_part/micro_laser = 5,
		/datum/stock_part/matter_bin = 1,
		/obj/item/stack/cable_coil = 2)
	needs_anchored = FALSE

/datum/design/board/adipoelectric_generator
	name = "Machine Design (Adipoelectric Generator Board)"
	desc = "The circuit board for an Adipoelectric Generator."
	id = "adipoelectric_generator"
	build_path = /obj/item/circuitboard/machine/power/adipoelectric_generator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

#undef KILO_WATT
#undef MEGA_WATT
#undef WATTS_PER_BFI
