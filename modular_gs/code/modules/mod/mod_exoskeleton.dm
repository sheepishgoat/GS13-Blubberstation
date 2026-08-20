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
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*10, /datum/material/glass = SHEET_MATERIAL_AMOUNT*5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT*2.5)

/obj/item/mod/control/pre_equipped/exoskeleton/locked
	name = "MOD control unit (locked)"
	desc = "A pre-built GATO mobility exoskeleton, designed to support high weights, favor movement and weight loss. This model's modules cannot be removed."
	theme = /datum/mod_theme/exoskeleton/locked

/obj/item/mod/control/pre_equipped/exoskeleton/wrench_act(mob/living/user, obj/item/wrench)
	if(seconds_electrified && get_charge() && shock(user))
		return ITEM_INTERACT_BLOCKING
	if(open)
		balloon_alert(user, "core cannot be removed!")
		playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return ITEM_INTERACT_BLOCKING

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
