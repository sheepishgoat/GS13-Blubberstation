/datum/armor/structure_window_calorite
	melee = 10
	fire = 80
	acid = 100

/obj/structure/window/calorite
	name = "calorite window"
	desc = "A window made out of a calorite-silicate alloy."
	icon = 'modular_gs/icons/obj/structure/structures.dmi'
	icon_state = "calorite_window"
	armor_type = /datum/armor/structure_window_calorite
	max_integrity = 30
	glass_type = /obj/item/stack/sheet/calorite_glass
	rad_insulation = RAD_MEDIUM_INSULATION
	glass_material_datum = /datum/material/alloy/calorite_glass
	custom_materials = list(/datum/material/calorite = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/structure/window/calorite/Initialize(mapload, direct)
	// fattening amount half that of a calorite wall - because you can push it,
	// and we probably don't wanna someone to bloat up just from pushing it across
	// the hallway. Lore reason is that it's calorite and glass so not as potent
	AddComponent(\
		/datum/component/fattening,\
		5,\
		FATTENING_TYPE_ITEM,\
		item_touch = TRUE\
	)
	. = ..()

/obj/structure/window/calorite/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if (!.)
		return

	if (istype(mover, /obj/projectile/beam))
		var/obj/projectile/laser = mover
		var/fat_power_to_add = max(laser.fat_added + 25, laser.fat_added * 1.1)
		fat_power_to_add = min(fat_power_to_add, 5000 + initial(laser.fat_added))
		laser.fat_added = fat_power_to_add

/obj/structure/window/calorite/unanchored
	anchored = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/window/calorite/spawner, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/window/calorite/unanchored/spawner, 0)


/obj/structure/window/calorite/fulltile
	name = "full tile calorite window"
	desc = "A full tile window made out of a calorite-silicate alloy."
	icon = 'modular_gs/icons/obj/structure/window_calorite.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	fulltile = TRUE
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_WALLS
	flags_1 = PREVENT_CLICK_UNDER_1
	obj_flags = CAN_BE_HIT
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WINDOW_FULLTILE
	glass_amount = 2
	max_integrity = 60
	custom_materials = list(/datum/material/calorite = 2 * SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/structure/window/calorite/fulltile/unanchored
	anchored = FALSE
