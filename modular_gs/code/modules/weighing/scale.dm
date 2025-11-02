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

	var/buildstacktype = /obj/item/stack/sheet/iron
	var/buildstackamount = 3
	//stores the weight of the last person to step on in Lbs
	var/lastreading = 0
	/// What datum are we using to track weight?
	var/datum/component/weigh_out/weight_component

/obj/structure/scale/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH && !(flags_1 & NO_DEBRIS_AFTER_DECONSTRUCTION))
		W.play_tool_sound(src)
		deconstruct()

	return ..()

/obj/structure/scale/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(weighperson),
		COMSIG_ATOM_EXITED = PROC_REF(stop_weighing),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	weight_component = AddComponent(/datum/component/weigh_out)

/obj/structure/scale/Destroy(force)
	if(weight_component)
		qdel(weight_component)

	return ..()

/obj/structure/scale/examine(mob/user)
	. = ..()
	. += "Its last reading was: [src.lastreading]Lbs"
	. += "<span class='notice'>It's held together by a couple of <b>bolts</b>.</span>"

/obj/structure/scale/proc/weighEffect(mob/living/carbon/human/fatty)
	to_chat(fatty, "<span class='notice'>You weigh yourself.</span>")
	to_chat(fatty, "<span class='notice'>The numbers on the screen tick up and eventually settle on:</span>")
	//The appearance of the numbers changes with the fat level of the character
	if (HAS_TRAIT(fatty, TRAIT_BLOB))
		to_chat(fatty, "<span class='userdanger'><span class='big'>[round(src.lastreading/2000, 0.01)]TONS!!!</span></span>")

	else if (HAS_TRAIT(fatty, TRAIT_IMMOBILE))
		to_chat(fatty, "<span class='boldannounce'>[src.lastreading]Lbs!</span>")

	else if(HAS_TRAIT(fatty, TRAIT_OBESE) || HAS_TRAIT(fatty, TRAIT_MORBIDLYOBESE))
		to_chat(fatty, "<span class='alert'>[src.lastreading]Lbs!</span>")

	else
		to_chat(fatty, "<span class='notice'>[src.lastreading]Lbs.</span>")

/obj/structure/scale/proc/weighperson(datum/source, var/mob/living/carbon/fatty)
	SIGNAL_HANDLER
	if(!istype(fatty) || (fatty.movement_type & FLYING))
		return FALSE

	src.lastreading = fatty.calculate_weight_in_pounds()
	weighEffect(fatty)
	visible_message("<span class='notice'>[fatty] weighs themselves.</span>")
	visible_message("<span class='notice'>The numbers on the screen settle on: [src.lastreading]Lbs.</span>")
	visible_message("<span class='notice'>The numbers on the screen read out: [fatty] has a BFI of [fatty.fatness].</span>")

	weight_component.currently_weighing = TRUE
	weight_component.most_recent_carbon = fatty

/obj/structure/scale/proc/stop_weighing(datum/source)
	SIGNAL_HANDLER
	weight_component.currently_weighing = FALSE

/obj/structure/scale/ui_interact(mob/user)
	weight_component.ui_interact(user)
