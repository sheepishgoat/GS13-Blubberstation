/obj/item/borg/upgrade/cookiesynth
	name = "cyborg cookie synthesizer"
	desc = "An extra module that allows cyborgs to dispense cookies."
	icon_state = "module_general"
	items_to_add = list(/obj/item/rsf/cookiesynth)
	custom_materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.125,
		/datum/material/plasma= SHEET_MATERIAL_AMOUNT * 1.5
		)
