// we only want to load xenoarch when we aren't unit testing OR we are NOT on the gateway test map
// xenoarch is much too fat to fit in memory alongside all the away missions, and as such
// it causes the gateway test map CI to fail
/datum/controller/subsystem/mapping/proc/load_xenoarch(list/FailedZs)
#ifdef UNIT_TESTS
	if (SSmapping.current_map.load_all_away_missions)	// this is because the gateway test map is too fat to exist alongside xenoarch on only 4GB of RAM
		return
	if (SSmapping.is_planetary())	// so apparently moon is too fat too
		return

	log_world("Loading Xenoarch with unit tests running.")
	LoadGroup(FailedZs, "Lavaland_Xenoarch", "map_files/GS_Xenoarch", "Lavaland_Xenoarch.dmm", default_traits = ZTRAITS_LAVALAND_XENOARCH)
#else
	log_world("Loading Xenoarch with no unit tests running.")
	LoadGroup(FailedZs, "Lavaland_Xenoarch", "map_files/GS_Xenoarch", "Lavaland_Xenoarch.dmm", default_traits = ZTRAITS_LAVALAND_XENOARCH)
#endif

/datum/controller/subsystem/mapping/proc/setup_xenoarch_dungeon()
	for (var/obj/effect/landmark/xenoarch_dungeon_spawner/landmark as anything in GLOB.xenoarch_dungeon_spawns)
		var/map_file = pick(landmark.room_list)
		var/datum/map_template/dungeon = new /datum/map_template((XENOARCH_RUIN_DIRECTORY + map_file), map_file)
		var/turf/spawn_area = get_turf(landmark)
		dungeon.load(spawn_area, TRUE)
		qdel(landmark)
