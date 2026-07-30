/mob/living/carbon/proc/xwg_resize()
	var/datum/component/temporary_size/existing_size_component = GetComponent(/datum/component/temporary_size)
	if (!ishuman(src))
		return FALSE

	if(isnull(existing_size_component) && !QDELETED(src))
		AddComponent(/datum/component/temporary_size/xwg)

	SEND_SIGNAL(src, COMSIG_WEIGHT_ADJUSTED)
	return TRUE

/datum/component/temporary_size/xwg
	var/being_destroyed = FALSE

/datum/component/temporary_size/xwg/Initialize(size_to_apply)
	. = ..()
	if (. == COMPONENT_INCOMPATIBLE)
		return .

	RegisterSignal(parent, COMSIG_WEIGHT_ADJUSTED, PROC_REF(calculate_weight_size))

/datum/component/temporary_size/xwg/proc/calculate_weight_size()
	SIGNAL_HANDLER

	var/mob/living/carbon/human/human_parent = parent
	if (!istype(human_parent))
		return

	var/weight_scaling_pref = human_parent?.client?.prefs.read_preference(/datum/preference/toggle/weight_size_scaling)
	var/fatness_size_modifier = sqrt(human_parent.fatness / FATNESS_LEVEL_BLOB)

	if (!weight_scaling_pref)
		// in case someone disabled XWG while being large, make sure to reset
		if (target_size != original_size)
			target_size = original_size
			apply_size(original_size)
		return

	// if this is true then applying would shrink us which makes no sense
	if (fatness_size_modifier <= 1)
		// if this is true, then that means we just lost weight and we've fallen
		// below the threshold for xwg. Apply default size
		if (target_size != original_size)
			target_size = original_size
			apply_size(original_size)
		return

	var/max_size = RESIZE_BIG
	if(human_parent?.client?.prefs.read_preference(/datum/preference/toggle/size_xwg))
		max_size = RESIZE_MACRO

	fatness_size_modifier *= original_size
	fatness_size_modifier = max(fatness_size_modifier, original_size)
	fatness_size_modifier = min(fatness_size_modifier, max_size)

	// don't change if we're at the target size already
	if (fatness_size_modifier == target_size)
		return

	target_size = fatness_size_modifier

	check_area()

/datum/component/temporary_size/xwg/check_area()
	var/area/current_area = get_area(parent)
	var/size_max = RESIZE_BIG

	if(!length(allowed_areas) || is_type_in_list(current_area, allowed_areas))
		size_max = RESIZE_MACRO

	var/size_to_apply = min(target_size, size_max)
	apply_size(size_to_apply)

	return TRUE

/datum/component/temporary_size/xwg/Destroy(force, silent)
	being_destroyed = TRUE
	return ..()

/datum/component/temporary_size/xwg/apply_size(size_to_apply)
	/*
	This component will pretty much only get destroyed when the default
	`/datum/component/temporary_size` is applied and destroys this one.

	By that time, the default component has already applied its size,
	so reseting it back to default here would remove the correctly applied size
	*/
	if (being_destroyed)
		return FALSE

	return ..()
