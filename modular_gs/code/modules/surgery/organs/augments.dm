/obj/item/organ/cyberimp/chest/nutriment/turbo
	name = "Nutriment pump implant TURBO"
	desc = "This implant was meant to prevent people from going hungry, but due to a flaw in its designs, it permanently produces a small amount of nutriment overtime."
	hunger_threshold = NUTRITION_LEVEL_FULL
	poison_amount = 10
	send_messages = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/glass = SHEET_MATERIAL_AMOUNT *0.325, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.5)

/obj/item/organ/cyberimp/chest/mobility
	name = "Mobility Nanite Core"
	desc = "This implant contains nanites that reinforce leg muscles, allowing for unimpeded movement at extreme weights."
	icon_state = "reviver_implant"
	slot = ORGAN_SLOT_MOBILITY
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/glass = SHEET_MATERIAL_AMOUNT *0.325, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.5)

/obj/item/organ/cyberimp/chest/mobility/on_mob_insert(mob/living/carbon/human/insertee, special = FALSE, movement_flags)
	..()
	ADD_TRAIT(insertee, TRAIT_NO_FAT_SLOWDOWN, REF(src))

/obj/item/organ/cyberimp/chest/mobility/on_mob_remove(mob/living/carbon/human/removee, special, movement_flags)
	REMOVE_TRAIT(removee, TRAIT_NO_FAT_SLOWDOWN, REF(src))
	..()
