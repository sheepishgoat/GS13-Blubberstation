/obj/structure/falsewall/calorite            //GS13
	name = "calorite wall"
	desc = "A wall with calorite plating. Burp."
	icon = 'modular_gs/icons/turf/false_walls.dmi'
	fake_icon = 'modular_gs/icons/turf/calorite_wall.dmi'
	icon_state = "calorite_wall-open"
	base_icon_state = "calorite_wall"
	mineral = /obj/item/stack/sheet/mineral/calorite
	walltype = /turf/closed/wall/mineral/calorite
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CALORITE_WALL + SMOOTH_GROUP_WALLS
	canSmoothWith = SMOOTH_GROUP_CALORITE_WALL

/obj/structure/falsewall/calorite/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/fattening,\
		10,\
		FATTENING_TYPE_ITEM,\
		item_touch = TRUE\
	)
