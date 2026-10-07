/turf/closed/indestructible/candy
	name = "Candy wall"
	desc = "Despite being made out of mere candy, this wall is harder than stone!"
	icon = 'modular_gs/icons/turf/walls/wall_candy.dmi'
	icon_state = "candywall"


/turf/closed/indestructible/chocolate
	name = "Chocolate wall"
	desc = "Somehow, it doesn't melt at all..."
	icon = 'modular_gs/icons/turf/walls/wall_candy.dmi'
	icon_state = "choco_wall1"

// #region snaxi turfs

/turf/closed/mineral/random/snow/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS
	turf_type = /turf/open/misc/asteroid/snow/snaxi
	baseturfs = /turf/open/misc/asteroid/snow/snaxi

/turf/closed/mineral/gibtonite/ice/snaxi
	icon = MAP_SWITCH('modular_zubbers/icons/turf/walls/icerock_wall.dmi', 'icons/turf/mining.dmi')
	turf_type = /turf/open/misc/asteroid/snow/ice/snaxi
	baseturfs = /turf/open/misc/asteroid/snow/ice/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS

/turf/closed/indestructible/rock/snow/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS

/turf/closed/indestructible/rock/snow/ice/snaxi
	initial_gas_mix = SNAXI_DEFAULT_ATMOS

// #endregion
