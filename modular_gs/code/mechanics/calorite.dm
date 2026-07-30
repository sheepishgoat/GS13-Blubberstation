/datum/material/calorite
	name = "calorite"
	color = "#eb6e00"
	// strength_modifier = 1.5
	// integrity_modifier = 0.25
	mat_flags = MATERIAL_SILO_STORED | MATERIAL_CLASS_METAL | MATERIAL_CLASS_RIGID
	mat_properties = list(
		MATERIAL_DENSITY = 7,
		MATERIAL_HARDNESS = 2,
		MATERIAL_FLEXIBILITY = 9,
		MATERIAL_REFLECTIVITY = 2,
		MATERIAL_ELECTRICAL = 6,
		MATERIAL_THERMAL = 6,
		MATERIAL_CHEMICAL = 4,
	)
	sheet_type = /obj/item/stack/sheet/mineral/calorite
	ore_type = /obj/item/stack/ore/calorite
	value_per_unit = 110 / SHEET_MATERIAL_AMOUNT
	tradable = TRUE
	tradable_base_quantity = MATERIAL_QUANTITY_RARE
	// beauty_modifier = 0.05
	// armor_modifiers = list(MELEE = 1.1, BULLET = 1.1, LASER = 1.15, ENERGY = 1.15, BOMB = 1, BIO = 1, FIRE = 0.7, ACID = 1.1) // Same armor as gold.
	mineral_rarity = MATERIAL_RARITY_PRECIOUS
	points_per_unit = 40 / SHEET_MATERIAL_AMOUNT
	// fish_weight_modifier = 1.5 // fishing values copied from gold
	// fishing_difficulty_modifier = -8
	// fishing_cast_range = 1
	// fishing_experience_multiplier = 0.75
	// fishing_completion_speed = 1.2
	// fishing_bait_speed_mult = 1.1
	// fishing_deceleration_mult = 1.2
	// fishing_bounciness_mult = 0.8
	// fishing_gravity_mult = 1.2

/datum/material/calorite/on_applied(atom/source, amount, multiplier, from_slot) // used to be material_flags instead of multiplier
	. = ..()
	// if(!(material_flags & MATERIAL_AFFECT_STATISTICS))
	// 	return

	if (isobj(source))
		var/obj/source_obj = source
		source_obj.damtype = FAT
		source_obj.AddComponent(\
		/datum/component/fattening,\
		amount / 50,\
		FATTENING_TYPE_ITEM\
		)

/datum/material/calorite/on_removed(atom/source, multiplier, from_slot) // used to be material_flags instead of multiplier
	// if(!(material_flags & MATERIAL_AFFECT_STATISTICS))
	// 	return ..()

	if (isobj(source))
		var/obj/source_obj = source
		source_obj.damtype = initial(source_obj.damtype)
		qdel(source.GetComponent(/datum/component/fattening))
		return ..()

/obj/item/stack/ore/calorite
	name = "calorite ore"
	singular_name = "calorite ore chunk"
	icon = 'modular_gs/icons/obj/mining.dmi'
	icon_state = "calorite_ore"
	singular_name = "Calorite ore chunk"
	points = 40
	mats_per_unit = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/calorite
	mine_experience = 20
	scan_icon = 'modular_gs/icons/effects/ore_visuals.dmi'
	scan_state = "rock_Calorite"
	merge_type = /obj/item/stack/ore/calorite

/obj/item/stack/sheet/mineral/calorite
	name = "calorite"
	icon = 'modular_gs/icons/obj/stack_objects.dmi'
	icon_state = "sheet-calorite"
	singular_name = "calorite sheet"
	mats_per_unit = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/mineral/calorite
	material_type = /datum/material/calorite
	walltype = /turf/closed/wall/mineral/calorite

/obj/item/stack/sheet/mineral/calorite/grind_results()
	return list(/datum/reagent/consumable/lipoifier = 2, /datum/reagent/micro_calorite = 1)

/obj/item/stack/sheet/mineral/calorite/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	AddComponent(\
		/datum/component/fattening,\
		2,\
		FATTENING_TYPE_ITEM\
		)
	. = ..()


/obj/item/stack/sheet/mineral/calorite/get_main_recipes()
	. = ..()
	. += GLOB.calorite_recipes

/obj/item/stack/sheet/mineral/calorite/five
	amount = 5

/obj/item/stack/sheet/mineral/calorite/ten
	amount = 10

/obj/item/stack/sheet/mineral/calorite/fifty
	amount = 50

/datum/export/material/market/calorite
	material_id = /datum/material/calorite
	message = "cm3 of calorite"

/turf/closed/mineral/calorite
	mineral_type = /obj/item/stack/ore/calorite
	scan_icon = 'modular_gs/icons/effects/ore_visuals.dmi'
	scan_state = "rock_Calorite"

/turf/closed/mineral/calorite/volcanic //for mapping
	turf_type = /turf/open/misc/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/misc/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

GLOBAL_LIST_INIT(calorite_recipes, list ( \
	new/datum/stack_recipe("calorite tile", /obj/item/stack/tile/mineral/calorite, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("Fatty statue", /obj/structure/statue/calorite/fatty, 5, time = 10 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_ONE_PER_TURF),\
	new/datum/stack_recipe("Calorite doors", /obj/structure/mineral_door/calorite, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),\
	))

/obj/item/ingot/calorite
	custom_materials = list(/datum/material/calorite=1500)

/datum/design/calorite
	name = "Calorite"
	id = "calorite"
	build_type = AUTOLATHE
	materials = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/mineral/calorite
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MATERIALS,
	)
