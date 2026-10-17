/obj/machinery/power/superparticlegen/update_overlays()
	. = ..()
	if(on && (superparticle_gas_flags & SP_GAS_FLAG_LIPOIFIUM))
		. += mutable_appearance(icon = 'modular_gs/icons/obj/machines/superparticle_projector.dmi', icon_state = "superparticle_lipoifium")
