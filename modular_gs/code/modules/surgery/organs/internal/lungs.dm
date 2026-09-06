/obj/item/organ/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/lipoifium, while_present = PROC_REF(consume_lipoifium))
	add_gas_reaction(/datum/gas/galbanium, while_present = PROC_REF(consume_galbanium))
	add_gas_reaction(/datum/gas/water_vapor, while_present = PROC_REF(consume_water_vapor))
	if(!safe_nitro_min)
		add_gas_reaction(/datum/gas/nitrogen, while_present = PROC_REF(consume_nitrogen))

// removes all N2 from the breath. This makes it so that players will no longer suffocate in dorms.
/obj/item/organ/lungs/proc/consume_nitrogen(mob/living/carbon/breather, datum/gas_mixture/breath, nitrogen_pp, old_nitrogen_pp)
	breathe_gas_volume(breath, /datum/gas/nitrogen)
