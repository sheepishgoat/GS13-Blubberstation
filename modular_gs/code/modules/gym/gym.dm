/obj/item/dumbbell
	desc = "A weighty dumbbell, perfect for arm exercise!"
	name = "dumbbell"
	icon = 'modular_gs/icons/obj/dumbbell.dmi'
	icon_state = "pen"
	throwforce = 20
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 3
	custom_materials = list(/datum/material/iron=10)
	pressure_resistance = 2
	var/reps = 0
	var/using = FALSE

/obj/item/dumbbell/dropped(mob/user, silent)
	reps = 0
	. = ..()

/obj/item/dumbbell/attack_self(mob/user)
	. = ..()
	if(using)
		return

	var/mob/living/carbon/lifter = user
	if(!istype(lifter))
		to_chat(user, span_notice("You don't feel like using this would do you much good."))
		return

	using = TRUE
	to_chat(user, "<span>You do a rep with the [src]. YEEEEEAH!!!</span>")
	if(do_after(user, CLICK_CD_RESIST-reps && lifter.work_out(1), src))
		if(reps < 16)
			reps += 0.4
	else
		to_chat(user, "<span>You couldn't complete the rep. YOU'LL GET IT NEXT TIME CHAMP!!!</span>")
	using = FALSE

/obj/machinery/treadmill
	name = "treadmill"
	desc = "A treadmil, for losing weight!"
	icon = 'modular_gs/icons/obj/structure/treadmill.dmi'
	icon_state = "treadmill"
	circuit = /obj/item/circuitboard/machine/treadmill

	var/stamina_cost_divider = 1

/obj/machinery/treadmill/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_try_exit)
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/machinery/treadmill/proc/on_try_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(machine_stat & BROKEN)
		return

	if(!isliving(leaving))
		return

	var/mob/living/M = leaving

	if(!isnull(M.throwing) || (M.movement_type & (FLOATING|FLYING))) //Make sure they're not going over it
		return

	if(direction != dir) //Make sure they're going into the treadmill
		return

	if(prob(25))
		playsound(src, "sound/machines/tractor_running.ogg", 25, TRUE, -2) //Rumblin'

	flick("conveyor-1", src)

	if(!iscarbon(M))
		return

	var/mob/living/carbon/fatty = M		// if you're using it, it's probably because you want to lose weight. If you have weight to lose, you are a fatty. >:3
	if(fatty.fatness > FATNESS_LEVEL_BARELYMOBILE)
		if(prob(5))
			visible_message(pick(list(	//Really testing the poor thing, huh?
				"\The [src] audibly strains under [fatty]'s weight...",
				"\The [src] creeaaaaks under [fatty]'s strain..."
			)))
	var/base_intensity = 0.125
	var/custom_stamina_cost = (base_intensity * INTENSITY_TO_STAMINA_RATIO) / stamina_cost_divider

	fatty.work_out(base_intensity, custom_stamina_cost)
	return COMPONENT_ATOM_BLOCK_EXIT

/obj/machinery/treadmill/RefreshParts(obj/item/O, mob/user, params)
	..()
	for(var/obj/item/stock_parts/servo/servo in component_parts)
		stamina_cost_divider += servo.rating * 1

/obj/machinery/treadmill/attackby(obj/item/item, mob/living/user, params)
	if(default_deconstruction_screwdriver(user, "treadmill", "treadmill", item))
		return TRUE

	if(default_deconstruction_crowbar(item))
		return TRUE

	if(default_change_direction_wrench(user, item))
		return TRUE

	return ..()

/obj/item/circuitboard/machine/treadmill
	name = "Treadmill (Machine Board)"
	build_path = /obj/machinery/treadmill
	req_components = list(/obj/item/stock_parts/servo = 1)

/datum/design/treadmill
	name = "Treadmill Board"
	id = "treadmill"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/circuitboard/machine/treadmill
	category = list("inital", "Construction")
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/dumbbell
	name = "Dumbbell"
	id = "dumbbell"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/dumbbell
	category = list("initial", "Tools")
/*
/datum/design/treadmill
	name = "Treadmill"
	id = "treadmill"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 5000)
	build_path = /obj/item/conveyor_construct/treadmill
	category = list("initial", "Construction")
*/
