/datum/map_generator/cave_generator/snaxi
	weighted_open_turf_types = list(/turf/open/misc/asteroid/snow/icemoon = 19, /turf/open/misc/ice/icemoon = 1)
	weighted_closed_turf_types = list(
		/turf/closed/mineral/random/snow = 100,
		/turf/closed/mineral/gibtonite/ice/icemoon = 2,
	)

	weighted_mob_spawn_list = list(
		/mob/living/basic/mining/goldgrub = 10,
		/mob/living/basic/mining/legion/snow = 50,
		/mob/living/basic/mining/lobstrosity = 15,
		/mob/living/basic/mining/wolf = 50,
		/obj/effect/spawner/random/lavaland_mob/raptor = 15,
		/mob/living/basic/mining/polarbear = 30,
		/obj/structure/spawner/ice_moon = 3,
		/obj/structure/spawner/ice_moon/polarbear = 3,
	)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/chilly = 2,
		/obj/structure/flora/grass/both/style_random = 6,
		/obj/structure/flora/rock/icy/style_random = 2,
		/obj/structure/flora/rock/pile/icy/style_random = 2,
		/obj/structure/flora/tree/pine/style_random = 2,
	)

	///Note that this spawn list is also in the lavaland generator
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 8,
		/obj/structure/geyser/plasma_oxide = 8,
		/obj/structure/geyser/protozine = 8,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 8,
		/obj/structure/geyser/chiral_buffer = 8,
		/obj/structure/ore_vent/boss/icebox = 1,
	)

/datum/map_generator/cave_generator/snaxi/surface
	weighted_open_turf_types = list(/turf/open/misc/asteroid/snow/icemoon = 1)
	flora_spawn_chance = 60
	weighted_mob_spawn_list = null
	noise_percent = 100 // Full floor

	feature_spawn_chance = 0.15
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 8,
		/obj/structure/geyser/plasma_oxide = 8,
		/obj/structure/geyser/protozine = 8,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 8,
		/obj/structure/geyser/chiral_buffer = 8,
	)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/ash/chilly = 2,
		/obj/structure/flora/grass/both/style_random = 20,
		/obj/structure/flora/tree/pine/style_random = 2,
	)
