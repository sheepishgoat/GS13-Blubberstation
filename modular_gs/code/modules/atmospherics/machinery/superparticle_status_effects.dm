/datum/status_effect/atmosgenbuff_lipoifium
	id = "atmosgen_buff_lipoifium"
	duration = 3 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/atmosgenbuff_lipoifium/tick(seconds_between_ticks)
	if(!iscarbon(owner))
		return
	
	var/mob/living/carbon/owner_carbon = owner
	owner_carbon.adjust_fatness(1 * seconds_between_ticks, FATTENING_TYPE_ITEM)	// idk what fattening type this should be, item magic and atmos all fit
