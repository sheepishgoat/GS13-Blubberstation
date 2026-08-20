/datum/design/bluespace_belt
	name = "Bluespace Belt"
	desc = "A belt made using bluespace technology. The power of space and time, used to hide the fact you are fat."
	id = "bluespace_belt"
	build_type = PROTOLATHE
	construction_time = 100
	materials = list(
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.2,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.1,
		)
	build_path = /obj/item/bluespace_belt
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/primitive_bluespace_belt
	name = "Primitive Bluespace Belt"
	desc = "A primitive belt made using bluespace technology. The power of space and time, used to hide the fact you are fat. This one requires cells to continue operating, and may suffer from random failures."
	id = "primitive_bluespace_belt"
	build_type = PROTOLATHE
	construction_time = 100
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.2,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.1,
		)
	build_path = /obj/item/bluespace_belt/primitive/empty
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/calorite_collar
	name = "Calorite Collar"
	desc = "A collar that amplifies caloric intake of the wearer."
	id = "calorite_collar"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/calorite = SHEET_MATERIAL_AMOUNT * 3)
	construction_time = 75
	build_path = /obj/item/clothing/neck/human_petcollar/calorite
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bluespace_collar_receiver
	name = "Bluespace collar receiver"
	desc = "A collar containing a miniaturized bluespace whitehole. Other bluespace transmitter collars can connect to this, causing the wearer to receive food from other transmitter collars directly into the stomach."
	id = "bluespace_collar_receiver"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/calorite = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.125)
	construction_time = 75
	build_path = /obj/item/clothing/neck/human_petcollar/locked/bluespace_collar_receiver
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/bluespace_collar_transmitter
	name = "Bluespace collar transmitter"
	desc = "A collar containing a miniaturized bluespace blackhole. Can be connected to a bluespace collar receiver to transmit food to a linked receiver collar. "
	id = "bluespace_collar_transmitter"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.25)
	construction_time = 75
	build_path = /obj/item/clothing/neck/human_petcollar/locked/bluespace_collar_transmitter
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SERVICE | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/berry_collar
	name = "WT field generator collar"
	desc = "A collar that prevents accidental bursting by generating a water-tight field."
	id = "blueberry_field_collar"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/calorite = SHEET_MATERIAL_AMOUNT *0.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.25)
	construction_time = 75
	build_path = /obj/item/clothing/neck/kink_collar/locked/antiburst
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO


/datum/design/cyberimp_nutriment_turbo
	name = "Nutriment Pump Implant TURBO"
	desc = "This implant was meant to prevent people from going hungry, but due to a flaw in its designs, it permanently produces a small amount of nutriment overtime."
	id = "ci-nutrimentturbo"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 100
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/glass = SHEET_MATERIAL_AMOUNT *0.325, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.5)
	build_path = /obj/item/organ/cyberimp/chest/nutriment/turbo
	category = list(RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_MISC)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cyberimp_fat_mobility
	name = "Mobility Nanite Core"
	desc = "This implant contains nanites that reinforce leg muscles, allowing for unimpeded movement at extreme weights."
	id = "ci-fatmobility"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 100
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/glass = SHEET_MATERIAL_AMOUNT *0.325, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.325, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.5)
	build_path = /obj/item/organ/cyberimp/chest/mobility
	category = list(RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_MISC)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cookie_synthesizer
	name = "Cookie Synthesizer"
	desc = "A self-charging miraculous device that's able to produce cookies."
	id = "cookie_synthesizer"
	build_type = PROTOLATHE
	construction_time = 100
	materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/calorite = SHEET_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/rsf/cookiesynth
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SERVICE

//these are made in mech fabricator
/datum/design/borg_cookie_synthesizer
	name = "Cyborg Upgrade (Cookie Synthesizer)"
	id = "borg_upgrade_cookiesynthesizer"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/cookiesynth
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/uranium = SHEET_MATERIAL_AMOUNT * 0.125, /datum/material/plasma= SHEET_MATERIAL_AMOUNT * 1.5)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES)


/*
/datum/design/borg_fatoray
	name = "Cyborg Upgrade (Fatoray)"
	id = "borg_upgrade_fatoray"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/fatoray
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/calorite = SHEET_MATERIAL_AMOUNT *5)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES)

/datum/design/borg_feedtube
	name = "Cyborg Upgrade (Feeding Tube)"
	id = "borg_upgrade_feedingtube"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/feedtube
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/calorite = SHEET_MATERIAL_AMOUNT *5)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES)
*/

/datum/design/borg_foodgrip
	name = "Cyborg Upgrade (Food Gripper)"
	id = "borg_upgrade_foodgrip"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/feeding_arm
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3
		)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES)

