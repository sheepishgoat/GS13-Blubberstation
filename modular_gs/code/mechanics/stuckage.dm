/obj/machinery/door/proc/check_door_stuckage(datum/source, atom/movable/leaving, direction)
	if (!istype(leaving, /mob/living/carbon))
		return

	var/mob/living/carbon/fatty = leaving

	if (isnull(fatty.client))
		return

	if (isnull(fatty.client.prefs))
		return

	var/stuckage_weight = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/stuckage)
	var/custom_chance_to_get_stuck = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/stuckage_custom)

	if (HAS_TRAIT(fatty, TRAIT_HELPLESS_STUCKAGE))
		stuckage_weight = FATNESS_LEVEL_EXTREMELY_OBESE
		custom_chance_to_get_stuck = 0

	if (stuckage_weight == 0)
		return

	if (got_stuck_in_door(fatty, stuckage_weight, custom_chance_to_get_stuck, src))
		fatty.visible_message("<span class'danger'>[fatty] gets stuck in the doorway!</span>")
		if (prob(15))
			to_chat(fatty, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
		fatty.Shake(duration = 0.1 SECONDS)
		update_integrity(atom_integrity - 1)
		return COMPONENT_ATOM_BLOCK_EXIT

/proc/got_stuck_in_door(mob/living/carbon/fatty, stuckage_weight, custom_chance_to_get_stuck, door)
	if(custom_chance_to_get_stuck && fatty.fatness > stuckage_weight)
		if(prob(custom_chance_to_get_stuck))
			return TRUE
		return FALSE
	
	if(fatty.fatness > (stuckage_weight * 2))
		if(prob(66))
			return TRUE
		return FALSE

	if(fatty.fatness > stuckage_weight)
		if(prob(40))
			return TRUE
		if(prob(20))
			to_chat(fatty, "<span class='danger'>With great effort, you manage to squeeze your massive form through  \the [door]. It's a tight fit, but you successfully navigate the narrow opening, barely avoiding getting stuck.</span>")
			return FALSE

	if(fatty.fatness > (stuckage_weight / 2))
		if(prob(20))
			fatty.visible_message("<span class'danger'>[fatty]'s hips brush against the doorway...</span>")
			to_chat(fatty, "<span class='danger'>As you pass through  \the [door], you feel a slight brushing against your hips. The [door] frame accommodates your form, but it's a close fit..</span>")
	
	return FALSE

/obj/structure/mineral_door/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(check_door_stuckage)
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/mineral_door/proc/check_door_stuckage(datum/source, atom/movable/leaving, direction)
	if (!istype(leaving, /mob/living/carbon))
		return

	var/mob/living/carbon/fatty = leaving

	if (isnull(fatty.client))
		return

	if (isnull(fatty.client.prefs))
		return

	var/stuckage_weight = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/stuckage)
	var/custom_chance_to_get_stuck = fatty.client.prefs.read_preference(/datum/preference/numeric/helplessness/stuckage_custom)

	if (HAS_TRAIT(fatty, TRAIT_HELPLESS_STUCKAGE))
		stuckage_weight = FATNESS_LEVEL_EXTREMELY_OBESE
		custom_chance_to_get_stuck = 0

	if (stuckage_weight == 0)
		return

	if (got_stuck_in_door(fatty, stuckage_weight, custom_chance_to_get_stuck, src))
		fatty.visible_message("<span class'danger'>[fatty] gets stuck in the doorway!</span>")
		if (prob(15))
			to_chat(fatty, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
		fatty.Shake(duration = 0.1 SECONDS)
		update_integrity(atom_integrity - 1)
		return COMPONENT_ATOM_BLOCK_EXIT
