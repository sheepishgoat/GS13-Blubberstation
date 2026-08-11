#define XENOARCH_RUIN_DIRECTORY "_maps/RandomRuins/LavaRuins/GS13/xenoarch_dungeons/"

GLOBAL_LIST_INIT(xenoarch_dungeon_ruins, list(
	"dungeon_room_1.dmm",
	"dungeon_room_2.dmm",
	"dungeon_room_3.dmm",
	"dungeon_room_4.dmm",
	"dungeon_room_5.dmm",
	"dungeon_room_6.dmm",
	"dungeon_room_7.dmm",
	"dungeon_room_8.dmm",
))

GLOBAL_LIST_EMPTY(xenoarch_dungeon_spawns)

/obj/effect/landmark/xenoarch_dungeon_spawner
	name = "Xenoarch dungeon spawner"
	anchored = TRUE
	layer = OBJ_LAYER
	plane = GAME_PLANE
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/effect/landmark/xenoarch_dungeon_spawner/Initialize(mapload)
	. = ..()
	if (!mapload)
		stack_trace("Attempted to place a xenoarch dungeon spawner after map load!")
		return

	GLOB.xenoarch_dungeon_spawns.Add(src)

/datum/controller/subsystem/mapping/proc/setup_xenoarch_dungeon()
	for (var/landmark in GLOB.xenoarch_dungeon_spawns)
		var/map_file = pick(GLOB.xenoarch_dungeon_ruins)
		var/datum/map_template/dungeon = new /datum/map_template((XENOARCH_RUIN_DIRECTORY + map_file), map_file)
		var/turf/spawn_area = get_turf(landmark)
		dungeon.load(spawn_area, TRUE)
		qdel(landmark)

/area/lavaland/underground/xenoarch/dungeon
	name = "Xenoarch Dungeon"

#undef XENOARCH_RUIN_DIRECTORY
