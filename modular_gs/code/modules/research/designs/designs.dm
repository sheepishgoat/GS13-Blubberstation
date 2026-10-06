/datum/design/weightanalyzer
	name = "Weight Analyzer"
	id = "weightanalyzer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5
		)
	build_path = /obj/item/portable_weight_scanner
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC
	)

/datum/design/borg_weight_analyzer
	name = "Borg Weight Analyzer"
	id = "borg_weightanalyzer"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/weight_analyzer
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT
		)
	construction_time = 100
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_feeding_tube
	name = "Borg Feeding Tube"
	id = "borg_feeding_tube"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/feeding_tube
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3
		)
	construction_time = 100
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/board/heft_scale
	name = "Machine Design (HEF-T Scale Board)"
	desc = "The circuit board for a HEF-T Scale."
	id = "heftscale"
	build_path = /obj/item/circuitboard/machine/heft_scale
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
