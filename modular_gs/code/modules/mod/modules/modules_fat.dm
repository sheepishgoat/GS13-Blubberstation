/// base amount of energy in joules gained from one BFI
#define JOULES_PER_BFI 25

/obj/item/mod/module/hydraulic_movement
	icon = 'modular_gs/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "hydraulic_mod"
	name = "MOD hydraulic movement assistance module"
	desc = "A module created by GATO, installed across the suit, featuring a system of hydraulic pistons \
		that support and lighten vast amounts of excess weight to provide easier movement."
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/hydraulic_movement)
	idle_power_cost = 5
	var/amount = -2
	var/modifier_name = "hydraulic_mod"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2.5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/mod/module/hydraulic_movement/locked
	name = "MOD hydraulic movement assistance module (locked)"
	removable = FALSE

/obj/item/mod/module/hydraulic_movement/on_part_activation()
	var/mob/living/carbon/human/wearer = mod.wearer
	wearer.add_fat_delay_modifier(modifier_name, amount)

	if(!HAS_TRAIT_FROM(wearer, TRAIT_NO_HELPLESSNESS, REF(src)))
		ADD_TRAIT(wearer, TRAIT_NO_HELPLESSNESS, REF(src))

	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
//		wearer.cure_nearsighted(HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_MUTE, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_MUTE, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
		REMOVE_TRAIT(wearer, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
		wearer.update_body_parts()
//	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)
	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
		REMOVE_TRAIT(wearer, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)
//	if(HAS_TRAIT_FROM(wearer, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
//		REMOVE_TRAIT(wearer, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

/obj/item/mod/module/hydraulic_movement/on_part_deactivation(deleting = FALSE)
	if(deleting)
		return
	if(HAS_TRAIT_FROM(mod.wearer, TRAIT_NO_HELPLESSNESS, REF(src)))
		REMOVE_TRAIT(mod.wearer, TRAIT_NO_HELPLESSNESS, REF(src))
	mod.wearer.remove_fat_delay_modifier(modifier_name)

/datum/design/module/hydraulic_movement
	name = "Hydraulic Assistance Module"
	id = "mod_hydraulic"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2.5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mod/module/hydraulic_movement
	desc = "A GATO-designed module that supports plumper bodies and allows easier movement."

/obj/item/mod/module/storage/locked
	name = "MOD storage containment module (locked)"
	removable = FALSE

/obj/item/mod/module/calovoltaic
	icon = 'modular_gs/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "calovoltaic_mod"
	name = "MOD calovoltaic generator module"
	desc = "A module created by GATO, capable of burning adipose tissue \
		to generate power for the suit it is installed onto."
	module_type = MODULE_TOGGLE
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/calovoltaic)
	var/rate = 10
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2.5)

/obj/item/mod/module/calovoltaic/locked
	name = "MOD calovoltaic generator module (locked)"
	removable = FALSE

/obj/item/mod/module/calovoltaic/on_select()
	. = ..()
	if(active)
		balloon_alert(mod.wearer, "activated!")
	else
		balloon_alert(mod.wearer, "deactivated!")

/obj/item/mod/module/calovoltaic/on_active_process(seconds_per_tick)
	if(!istype(mod.wearer, /mob/living/carbon))
		return
	
	var/mob/living/carbon/wearer = mod.wearer

	if (!(wearer.fatness_real > 0))
		return
	
	// adding a minus because we're losing weight (by default)
	var/burned_fat = -(wearer.adjust_fatness(-rate * seconds_per_tick, FATTENING_TYPE_WEIGHT_LOSS))
	// and here we clamp to 0 because we don't want to suck away charge if our weight loss rate is negative
	burned_fat = max(burned_fat, 0)
	mod.add_charge(burned_fat * JOULES_PER_BFI)

/datum/design/module/calovoltaic
	name = "Calovoltaic Generator Module"
	id = "mod_calovoltaic"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/mod/module/calovoltaic
	desc = "A GATO-designed module for burning excess fat to make power for your suit."

#undef JOULES_PER_BFI
