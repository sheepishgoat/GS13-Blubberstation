/datum/job/nanotrasen_consultant/get_lobby_icon()
	return icon('modular_gs/icons/mob/huds/hud.dmi', "hud_gato_consultant")

/obj/item/pen/fountain/pink
	name = "gato fountain pen"
	desc = "It's an expensive pink fountain pen. The case may be plastic, but that gold is real!"
	icon = 'modular_zubbers/icons/obj/service/bureaucracy.dmi'
	icon_state = "pen-fountain-nt"
	colour = "#c54fa1"
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT*7.5)

/obj/item/modular_computer/pda/nanotrasen_consultant
	greyscale_config = /datum/greyscale_config/tablet/stripe_thick
