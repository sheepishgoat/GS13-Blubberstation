/obj/item/borg/upgrade/weight_analyzer
	name = "borg weight analyzer module"
	desc = "A module that allows cyborgs to view and scan the weight of organic beings."
	icon_state = "module_general"

	items_to_add = list(/obj/item/portable_weight_scanner)
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT
		)

/obj/item/borg/upgrade/weight_analyzer/action(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	ADD_TRAIT(borg, TRAIT_FAT_SCANNER, "borg_module")

/obj/item/borg/upgrade/fatoray
	name = "borg fatoray module"
	desc = "This module allows the cyborg to shoot fattening projectiles. Harmless if you ignore the damage done to waistlines."
	icon_state = "module_peace"

	items_to_add = list(/obj/item/gun/energy/fatoray/weak/cyborg)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.5
		)

/obj/item/borg/upgrade/feeding_tube
	name = "borg feeding tube"
	desc = "This module allows the cyborg to feed organic lifeforms via an integrated feeding tube. It has the capability of generating the reagents it uses."
	icon_state = "module_peace"

	items_to_add = list(/obj/item/reagent_containers/borghypo/medical/feeding_tube)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3
		)

/obj/item/borg/upgrade/feeding_tube_upgrade
	name = "upgraded borg feeding tube"
	desc = "An upgraded feeding tube module, providing a wider range of reagents to be produced by the borg."
	icon_state = "module_peace"

	items_to_add = null
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.2,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.1,
		)

/obj/item/borg/upgrade/feeding_tube_upgrade/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	for(var/obj/item/reagent_containers/borghypo/medical/feeding_tube/hypo in borg.model.modules)
		hypo.upgrade_hypo()
		return TRUE
	
	return FALSE

/obj/item/borg/upgrade/feeding_tube_upgrade/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	for(var/obj/item/reagent_containers/borghypo/medical/feeding_tube/hypo in borg.model.modules)
		hypo.remove_hypo_upgrade()
		return TRUE
	
	return FALSE

/obj/item/borg/upgrade/feeding_tube/hacked
	name = "illegally upgraded borg feeding tube"
	icon_state = "module_illegal"

	items_to_add = list(/obj/item/reagent_containers/borghypo/medical/feeding_tube/hacked)
