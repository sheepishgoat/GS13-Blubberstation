/datum/design/fatoray_weak
	name = "Basic Fatoray"
	id = "fatoray_weak"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3, /datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.5)
	construction_time = 75
	build_path = /obj/item/gun/energy/fatoray/weak
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY

/datum/design/fatoray_cannon_weak
	name = "Basic Cannonshot Fatoray"
	id = "fatoray_cannon_weak"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.4, /datum/material/calorite = SHEET_MATERIAL_AMOUNT)
	construction_time = 200
	build_path = /obj/item/gun/energy/fatoray/cannon/weak
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY

/datum/design/alter_ray_metabolism
	name = "AL-T-Ray: Metabolism"
	id = "alter_ray_metabolism"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.4, /datum/material/calorite = SHEET_MATERIAL_AMOUNT * 1.3)
	construction_time = 200
	build_path = /obj/item/gun/energy/laser/alter_ray/gainrate
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY


/datum/design/alter_ray_reverser
	name = "AL-T-Ray: Reverser"
	id = "alter_ray_reverser"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.4, /datum/material/calorite = SHEET_MATERIAL_AMOUNT * 1.3)
	construction_time = 200
	build_path = /obj/item/gun/energy/laser/alter_ray/noloss
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY


/datum/design/borg_fatoray
	name = "Cyborg Upgrade (Fatoray)"
	id = "borg_upgrade_fatoray"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/fatoray
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.5
		)
	construction_time = 100
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/caloray
	name = "Caloray"
	id = "caloray"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.8
		)
	construction_time = 200
	build_path = /obj/item/gun/medbeam/caloray
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_RANGED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
