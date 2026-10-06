/datum/nifsoft/weight_display
	name = "Internal Scale"
	program_desc = "Gives the user access to a readout of their current body composition. This readout is only updated upon activation of the NIFSoft."
	activation_cost = 0.5
	purchase_price = 150
	able_to_keep = TRUE
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = "weight-scale"
	var/datum/component/weigh_out/weighing_component

/datum/nifsoft/weight_display/New(obj/item/organ/cyberimp/brain/nif/recipient_nif, no_rewards_points, skip_calibration)
	. = ..()
	weighing_component = AddComponent(/datum/component/weigh_out/embeded)

/datum/nifsoft/weight_display/Destroy(force)
	if(weighing_component)
		QDEL_NULL(weighing_component)

	return ..()


/datum/nifsoft/weight_display/activate()
	. = ..()
	if(!.)
		return FALSE

	weighing_component.weigh(linked_mob)
	weighing_component.ui_interact(linked_mob)


// The version of this component intended for NIFs or other use cases where you only want to UI to check if the user is awake.
/datum/component/weigh_out/embeded/ui_state(mob/user)
	return GLOB.conscious_state

