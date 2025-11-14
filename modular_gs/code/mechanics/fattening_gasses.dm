/obj/item/organ/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/lipoifium, while_present = PROC_REF(consume_lipoifium))

/obj/item/organ/lungs/proc/consume_lipoifium(mob/living/carbon/breather, datum/gas_mixture/breath, lipoifium_pp, old_lipoifium_pp)
	var/total_moles = breath.total_moles()
	var/lipoifium_moles = breathe_gas_volume(breath, /datum/gas/lipoifium)
	var/lipoifium_ratio = lipoifium_moles / total_moles

	if (lipoifium_pp < 0.1)	// less than 0.1 KPa of lipo
		return

	var/fatness_to_add = lipoifium_moles * 1500	// each mole gives 1500 BFI. Now, you may think that that's A METRIC FUCKTON, but in reality, because lungs by default are 0.5 liters, at 20C 101.325 kPa that's just 0.02 moles
	// fatness_to_add *= 10 * lipoifium_moles / total_moles
	if (lipoifium_ratio > 0.75 && lipoifium_pp > 16)	// if more than 75% of the air we breathe is lipo and we breathe at least 16 kPa of it
		if (lipoifium_ratio >= 0.96)	// if this is an internal and you're not suffocating them, means you're using pluox. Here, have a buff.
			fatness_to_add *= 1.5
		else
			fatness_to_add *= 1.1	// because fat you, that's why

	breather.adjust_fatness(fatness_to_add + 5, FATTENING_TYPE_ATMOS) // +5, so that we always get some decent BFI in
