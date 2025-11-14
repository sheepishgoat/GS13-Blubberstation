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

/obj/item/mod/module/hydraulic_movement/locked
	name = "MOD hydraulic movement assistance module (locked)"
	removable = FALSE

/obj/item/mod/module/hydraulic_movement/on_part_activation()
	var/mob/living/carbon/human/wearer = mod.wearer
	wearer.add_fat_delay_modifier(modifier_name, amount)

	if(!HAS_TRAIT_FROM(wearer, TRAIT_NO_HELPLESSNESS, src))
		ADD_TRAIT(wearer, TRAIT_NO_HELPLESSNESS, src)

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
	if(HAS_TRAIT_FROM(mod.wearer, TRAIT_NO_HELPLESSNESS, src))
		REMOVE_TRAIT(mod.wearer, TRAIT_NO_HELPLESSNESS, src)
	mod.wearer.remove_fat_delay_modifier(modifier_name)

/datum/design/module/hydraulic_movement
	name = "Hydraulic Assistance Module"
	id = "mod_hydraulic"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2.5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/mod/module/hydraulic_movement
	desc = "A GATO-designed module that supports plumper bodies and allows easier movement."

/obj/item/mod/module/calovoltaic
	icon = 'modular_gs/icons/obj/clothing/modsuit/mod_modules.dmi'
	icon_state = "calovoltaic_mod"
	name = "MOD calovoltaic generator module"
	desc = "A module created by GATO, capable of burning adipose tissue \
		to generate power for the suit it is installed onto."
	module_type = MODULE_TOGGLE
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/calovoltaic)
	var/rate = 5

/obj/item/mod/module/calovoltaic/locked
	name = "MOD calovoltaic generator module (locked)"
	removable = FALSE

/obj/item/mod/module/storage/locked
	name = "MOD storage containment module (locked)"
	removable = FALSE

/obj/item/mod/module/calovoltaic/on_select()
	. = ..()
	if(active)
		balloon_alert(mod.wearer, "activated!")
	else
		balloon_alert(mod.wearer, "deactivated!")

/obj/item/mod/module/calovoltaic/on_active_process(delta_time)
	if(istype(mod.wearer, /mob/living/carbon))
		var/mob/living/carbon/C = mod.wearer
		var/adjusted_rate = rate * C.weight_loss_rate
		if(C.fatness_real > 0 && (C.fatness_real - adjusted_rate) >= adjusted_rate)
			C.adjust_fatness(-rate, FATTENING_TYPE_WEIGHT_LOSS)
			mod.add_charge(rate)

/datum/design/module/calovoltaic
	name = "Calovoltaic Generator Module"
	id = "mod_calovoltaic"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2.5)
	build_path = /obj/item/mod/module/calovoltaic
	desc = "A GATO-designed module for burning excess fat to make power for your suit."

/obj/item/mod/construction/plating/exoskeleton
	theme = /datum/mod_theme/exoskeleton


/datum/armor/exoskeleton
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	bio = 5
	fire = 5
	acid = 5
	wound = 5
//list(MELEE = 5, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 5, BIO = 5, FIRE = 5, ACID = 5, WOUND = 5, RAD = 5)

/datum/mod_theme/exoskeleton
	name = "exoskeleton"
	desc = "The design for a GATO-branded mobility exoskeleton"
	extended_desc = "To combat the obesity epidemic that spreads on its stations, \
		GATO scientists have worked hard to create this simple yet efficient way to support \
		people whose weight proves restrictive and help them on their journey to lose it."
	default_skin = "exoskeleton"
	complexity_max = 5
	armor_type = /datum/armor/exoskeleton
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = 1
	min_cold_protection_temperature = -1
	//permeability_coefficient = 1
	siemens_coefficient = 1
	slowdown_deployed = 0
	//slowdown_inactive = 0
	//slowdown_active = 0
	inbuilt_modules = list(/obj/item/mod/module/hydraulic_movement, /obj/item/mod/module/calovoltaic, /obj/item/mod/module/storage)
	allowed_suit_storage = list(/obj/item/flashlight, /obj/item/tank/internals)
	variants = list(
		"exoskeleton" = list(
			MOD_ICON_OVERRIDE = 'modular_gs/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_gs/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_INVISIBILITY = NONE,
				SEALED_INVISIBILITY = NONE,
				SEALED_COVER = NONE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				SEALED_INVISIBILITY = NONE,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
		"invisible" = list(
			MOD_ICON_OVERRIDE = 'modular_gs/icons/obj/clothing/modsuit/mod_clothing.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_gs/icons/mob/clothing/modsuit/mod_clothing.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_INVISIBILITY = NONE,
				SEALED_INVISIBILITY = NONE,
				SEALED_COVER = NONE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				SEALED_INVISIBILITY = NONE,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = NONE,
				SEALED_CLOTHING = NONE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		)
	)

/datum/mod_theme/exoskeleton/locked
	inbuilt_modules = list(/obj/item/mod/module/hydraulic_movement/locked, /obj/item/mod/module/calovoltaic/locked, /obj/item/mod/module/storage/locked)

/obj/item/mod/control/pre_equipped/exoskeleton
	desc = "A pre-built GATO mobility exoskeleton, designed to support high weights, favor movement and weight loss."
	theme = /datum/mod_theme/exoskeleton
	applied_cell = /obj/item/stock_parts/power_store/cell/high

/obj/item/mod/control/pre_equipped/exoskeleton/locked
	name = "MOD control unit (locked)"
	desc = "A pre-built GATO mobility exoskeleton, designed to support high weights, favor movement and weight loss. This model's modules cannot be removed."
	theme = /datum/mod_theme/exoskeleton/locked

/datum/design/mod_shell/exoskeleton
	name = "MOD exoskeleton"
	desc = "A pre-built GATO mobility exoskeleton, designed to support high weights, favor movement and weight loss."
	id = "mod_exoskeleton"
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*10, /datum/material/glass = SHEET_MATERIAL_AMOUNT*5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/mod/control/pre_equipped/exoskeleton
	desc = "A GATO-designed assistance exoskeleton based on MODsuit tech."
	build_type = MECHFAB
	construction_time = 10 SECONDS
	category = list(RND_CATEGORY_MODSUITS + RND_SUBCATEGORY_MODUITS_CHASSIS)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/mod/control/pre_equipped/exoskeleton/wrench_act(mob/living/user, obj/item/wrench)
	if(seconds_electrified && get_charge() && shock(user))
		return ITEM_INTERACT_BLOCKING
	if(open)
		balloon_alert(user, "core cannot be removed!")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_BLOCKING

/*
/datum/gear/hands/exoskeleton
	name = "MOD exoskeleton"
	category = LOADOUT_CATEGORY_HANDS
	path = /obj/item/mod/control/pre_equipped/exoskeleton/locked
	cost = 3
*/
