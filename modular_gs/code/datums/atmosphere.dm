/datum/atmosphere/snaxi
	id = SNAXI_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=22,
		/datum/gas/nitrogen=82,
	)
	normal_gases = list(
		/datum/gas/oxygen=22,
		/datum/gas/nitrogen=82,
	)
	restricted_gases = list()
	restricted_chance = 0

	minimum_pressure = 90
	maximum_pressure = 100

	minimum_temp = ICEBOX_MIN_TEMPERATURE
	maximum_temp = 250	// ~20 below freezing
