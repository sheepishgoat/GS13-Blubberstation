GLOBAL_LIST_EMPTY(adipoelectric_transformer)

#define KILO_WATT *1000
#define MEGA_WATT *1000000
/// the base amount of power needed to bwomph someone up by one BFI.
/// Also decides the point at which the scaling slows down.
#define WATTS_PER_BFI	(500 KILO_WATT)

/obj/machinery/power/adipoelectric_transformer
	name = "adipoelectric transformer"
	desc = "This device uses calorite technology to store excess current in the wire it's placed on into whoever steps on!"
	icon = 'modular_gs/icons/obj/adipoelectric_transformer.dmi'
	icon_state = "state_off"
	density = FALSE
	use_power = NO_POWER_USE
	state_open = TRUE
	circuit = /obj/item/circuitboard/machine/adipoelectric_transformer
	occupant_typecache = list(/mob/living/carbon)
	/// multiplier to fat gained from power
	var/recharge_speed = 0
	var/lastprocessed = 0
	var/power_available = 0
	var/emp_timer = 0
	var/emp_multiplier = 5
	var/active = FALSE

// for mapping
/obj/machinery/power/adipoelectric_transformer/anchored
	anchored = TRUE

/obj/machinery/power/adipoelectric_transformer/Initialize(mapload)
	. = ..()
	if(anchored)
		connect_to_network()
	update_icon()

/obj/machinery/power/adipoelectric_transformer/RefreshParts()
	..()
	recharge_speed = 0
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		recharge_speed += capacitor.tier

/obj/machinery/power/adipoelectric_transformer/process(seconds_per_tick)
	if(!is_operational)
		return

	var/mob/living/carbon/carbon = occupant

	if(isnull(carbon) || !istype(carbon))
		visible_message(span_alert("The [src] buzzes. It needs someone standing on it to work."))
		playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50)
		active = FALSE
		return PROCESS_KILL

	if(isnull(powernet))
		visible_message(span_alert("[src] buzzes. Seems like it's not attached to a working power net."))
		playsound(src, 'sound/machines/buzz/buzz-two.ogg', 50)
		active = FALSE
		return PROCESS_KILL

	power_available = powernet.netexcess
	if(power_available <= 0)
		active = FALSE
		update_icon()
		return

	active = TRUE
	update_icon()

	if(power_available > WATTS_PER_BFI)
		power_available = power_available - WATTS_PER_BFI
		lastprocessed = (power_available / (WATTS_PER_BFI * 10)) + 1
	else
		lastprocessed = power_available / WATTS_PER_BFI

	add_load(power_available)

	if(!(world.time >= emp_timer + 600))
		lastprocessed = lastprocessed * emp_multiplier

	carbon.adjust_fatness(lastprocessed * recharge_speed * seconds_per_tick, FATTENING_TYPE_ITEM)
	return TRUE

/obj/machinery/power/adipoelectric_transformer/relaymove(mob/user)
	if(user.stat)
		return
	open_machine()

/obj/machinery/power/adipoelectric_transformer/emp_act(severity)
	. = ..()
	if(!(machine_stat & (BROKEN|NOPOWER)))
		if(occupant)
			src.visible_message("<span class='alert'>[src] emits ominous cracking noises!</span>")
			emp_timer = world.time //stuck in for 600 ticks, about 60 seconds

/obj/machinery/power/adipoelectric_transformer/can_be_unfasten_wrench(mob/user, silent)
	if(!state_open)
		to_chat(user, span_warning("Turn \the [src] off first!"))
		return FAILED_UNFASTEN

	return ..()

/obj/machinery/power/adipoelectric_transformer/wrench_act(mob/living/user, obj/item/tool)
	default_unfasten_wrench(user, tool)
	if (anchored)
		connect_to_network()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/adipoelectric_transformer/crowbar_act(mob/living/user, obj/item/tool)
	default_deconstruction_crowbar(tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/adipoelectric_transformer/screwdriver_act(mob/living/user, obj/item/item)
	if(!state_open)
		return ITEM_INTERACT_BLOCKING
	default_deconstruction_screwdriver(user, "state_open", "state_off", item)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/adipoelectric_transformer/interact(mob/user)
	toggle_open()
	return TRUE

/obj/machinery/power/adipoelectric_transformer/proc/toggle_open()
	if(state_open)
		close_machine()
	else
		open_machine()
	update_icon()

/obj/machinery/power/adipoelectric_transformer/open_machine(drop = TRUE, density_to_set = FALSE)
	if(!(world.time >= emp_timer + 600))
		return
	. = ..()
	active = FALSE
	GLOB.adipoelectric_transformer -= src
	STOP_PROCESSING(SSobj, src)

/obj/machinery/power/adipoelectric_transformer/close_machine(atom/movable/target, density_to_set = TRUE)
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

	GLOB.adipoelectric_transformer += src
	add_fingerprint(occupant)
	START_PROCESSING(SSobj, src)

/obj/machinery/power/adipoelectric_transformer/update_icon()
	. = ..()
	cut_overlays()
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
			if(!(world.time >= emp_timer + 600))
				icon_state = "state_overdrive"
				add_overlay("particles_overdrive")
			else
				icon_state = "state_on"
				add_overlay("particles_on")
	else
		icon_state = "state_off"

/obj/machinery/power/adipoelectric_transformer/power_change()
	..()
	update_icon()

/obj/machinery/power/adipoelectric_transformer/Destroy()
	. = ..()
	GLOB.adipoelectric_transformer -= src

/obj/machinery/power/adipoelectric_transformer/examine(mob/user)
	. = ..()
	if(is_operational)
		. += span_notice("[src]'s last reading on display was <b>[lastprocessed * recharge_speed]</b> adipose units.")
	else
		. += "<span class='notice'><b>[src]'s display is currently offline.</b></span>"

/obj/item/circuitboard/machine/adipoelectric_transformer
	name = "Adipoelectric Transformer"
	build_path = /obj/machinery/power/adipoelectric_transformer
	req_components = list(
		/datum/stock_part/capacitor = 5,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/mineral/calorite = 1)
	needs_anchored = FALSE

/datum/design/board/adipoelectric_transformer
	name = "Machine Design (Adipoelectric Transformer Board)"
	desc = "The circuit board for an Adipoelectric Transformer."
	id = "adipoelectric_transformer"
	build_path = /obj/item/circuitboard/machine/adipoelectric_transformer
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

#undef KILO_WATT
#undef MEGA_WATT
#undef WATTS_PER_BFI
