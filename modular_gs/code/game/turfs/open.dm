/turf/open/indestructible/chocolate
	name = "chocolate floor"
	desc = "A rather tasty floor, hopefully it does not ruin your shoes."
	icon = 'modular_gs/icons/turf/floor_candy.dmi'
	icon_state = "choclit_2"

/turf/open/indestructible/bubblegum
	name = "bubblegum floor"
	desc = "A rather tasty floor, hopefully it does not ruin your shoes."
	icon = 'modular_gs/icons/turf/floor_candy.dmi'
	icon_state = "floor_pinkgum"

/turf/open/candyfloor
	name = "candy grass"
	desc = "This weird grass smells of cinnamon and liquorice."
	icon = 'modular_gs/icons/turf/floor_candy.dmi'
	icon_state = "candyfloor"

/turf/open/chocolateriver
	gender = PLURAL
	name = "liquid chocolate"
	desc = "This is probably used for some kind of huge fountain."
	icon = 'modular_gs/icons/turf/floor_candy.dmi'
	icon_state = "chocwater"
	slowdown = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/floor/carpet/gato
	icon = 'modular_gs/icons/turf/carpet_gato.dmi'
	icon_state = "executive_carpet-255"
	base_icon_state = "executive_carpet"
	floor_tile = /obj/item/stack/tile/carpet/gato
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_CARPET_GATO
	canSmoothWith = SMOOTH_GROUP_CARPET_GATO

/obj/item/stack/tile/carpet/gato
	icon = 'modular_gs/icons/obj/tiles.dmi'
	name = "gato-themed carpet"
	icon_state = "tile-carpet-gato"
	turf_type = /turf/open/floor/carpet/gato
	merge_type = /obj/item/stack/tile/carpet/gato
	tile_reskin_types = null

// #region snaxi open turfs

/turf/open/misc/asteroid/snow/snaxi
	baseturfs = /turf/open/openspace/icemoon/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS
	slowdown = 0
	skip_minimap_rendering = TRUE

/turf/open/misc/ice/snaxi
	baseturfs = /turf/open/openspace/icemoon/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS
	slowdown = 0
	skip_minimap_rendering = TRUE

/turf/open/openspace/icemoon/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS
	baseturfs = /turf/open/openspace/icemoon/snaxi

/turf/open/openspace/icemoon/snaxi/Initialize(mapload)
	. = ..()
	baseturfs = /turf/open/openspace/icemoon/snaxi	// I hate this

/turf/open/openspace/icemoon/snaxi/keep_below
	drill_below = FALSE

/turf/open/misc/asteroid/snow/ice/snaxi
	baseturfs = /turf/open/misc/asteroid/snow/ice/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 0

/turf/open/floor/plating/snowed/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS

/turf/open/floor/plating/snowed/smoothed/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS

/turf/open/floor/plating/snowed/smoothed/standard_air
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/lava/plasma/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS
	baseturfs = /turf/open/lava/plasma/snaxi
	planetary_atmos = TRUE

/turf/open/floor/iron/solarpanel/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS

// #endregion
