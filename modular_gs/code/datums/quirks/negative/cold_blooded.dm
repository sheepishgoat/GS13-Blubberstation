/datum/quirk/cold_blooded
	name = "Cold blooded"
	desc = "For some reason, your body does not regulate its temperature on its own."
	icon = FA_ICON_THERMOMETER_HALF
	medical_record_text = "Patients is cold blooded."
	value = -2
	gain_text = span_notice("You suddenly feel colder")
	lose_text = span_notice("You feel a little warmer")
	quirk_flags = 0
	mob_trait = TRAIT_COLD_BLOODED
