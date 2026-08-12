GLOBAL_LIST_INIT(xenoarch_dungeon_rooms, list(
	"dungeon_room_1.dmm",
	"dungeon_room_2.dmm",
	"dungeon_room_3.dmm",
	"dungeon_room_4.dmm",
	"dungeon_room_5.dmm",
	"dungeon_room_6.dmm",
))

GLOBAL_LIST_INIT(xenoarch_dungeon_boss_rooms, list(
	"dungeon_room_7.dmm",
))

GLOBAL_LIST_INIT(xenoarch_dungeon_loot_rooms, list(
	"dungeon_room_8.dmm",
))

GLOBAL_LIST_EMPTY(xenoarch_dungeon_spawns)

/obj/effect/landmark/xenoarch_dungeon_spawner
	name = "Xenoarch dungeon spawner"
	icon = 'modular_gs/icons/effects/landmarks_static.dmi'
	icon_state = "room"
	anchored = TRUE
	layer = OBJ_LAYER
	plane = GAME_PLANE
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/list/room_list

/obj/effect/landmark/xenoarch_dungeon_spawner/Initialize(mapload)
	. = ..()
	if (!mapload)
		stack_trace("Attempted to place a xenoarch dungeon spawner after map load!")
		return

	room_list = GLOB.xenoarch_dungeon_rooms
	GLOB.xenoarch_dungeon_spawns.Add(src)

/obj/effect/landmark/xenoarch_dungeon_spawner/boss_room
	name = "Xenoarch dungeon boss room spawner"
	icon_state = "boss"

/obj/effect/landmark/xenoarch_dungeon_spawner/boss_room/Initialize(mapload)
	. = ..()
	room_list = GLOB.xenoarch_dungeon_boss_rooms

/obj/effect/landmark/xenoarch_dungeon_spawner/loot_room
	name = "Xenoarch dungeon loot room spawner"
	icon_state = "loot"

/obj/effect/landmark/xenoarch_dungeon_spawner/loot_room/Initialize(mapload)
	. = ..()
	room_list = GLOB.xenoarch_dungeon_loot_rooms
