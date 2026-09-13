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
	LoadGroup(FailedZs, "Lavaland_Xenoarch", "map_files/gs_maps", "Lavaland_Xenoarch.dmm", default_traits = ZTRAITS_LAVALAND_XENOARCH)
#else
	log_world("Loading Xenoarch with no unit tests running.")
	LoadGroup(FailedZs, "Lavaland_Xenoarch", "map_files/gs_maps", "Lavaland_Xenoarch.dmm", default_traits = ZTRAITS_LAVALAND_XENOARCH)
#endif
