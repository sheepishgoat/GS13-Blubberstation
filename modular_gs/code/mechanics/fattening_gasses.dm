/obj/item/organ/lungs/proc/consume_lipoifium(mob/living/carbon/breather, datum/gas_mixture/breath, lipoifium_pp, old_lipoifium_pp)
	var/lipoifium_moles = breathe_gas_volume(breath, /datum/gas/lipoifium)

	if (lipoifium_pp < 0.1)	// less than 0.1 KPa of lipo
		return

	var/fatness_to_add = lipoifium_moles * 750	// each mole gives 750 BFI. Now, you may think that that's A METRIC FUCKTON, but in reality, because lungs by default are 0.5 liters, at 20C 101.325 kPa that's just 0.02 moles

	breather.adjust_fatness(fatness_to_add, FATTENING_TYPE_ATMOS)

/obj/item/organ/lungs/proc/consume_galbanium(mob/living/carbon/breather, datum/gas_mixture/breath, galbanium_pp, old_galbanium_pp)
	var/total_moles = breath.total_moles()
	var/galbanium_moles = breathe_gas_volume(breath, /datum/gas/galbanium)
	var/galbanium_ratio = galbanium_moles / total_moles

	if (galbanium_pp < 0.1)	// less than 0.1 KPa of galb
		return

	var/fatness_to_add = galbanium_moles * 300	// each mole gives 300 perma BFI. Now, you may think that that's A METRIC FUCKTON, but in reality, because lungs by default are 0.5 liters, at 20C 101.325 kPa that's just 0.02 moles
	if (galbanium_ratio >= 0.96 && galbanium_pp > 16)	// if more than 96% of the air we breathe is galbanium and we breathe at least 16 kPa of it
		fatness_to_add *= 1.2

	breather.adjust_perma(fatness_to_add, FATTENING_TYPE_ATMOS)
