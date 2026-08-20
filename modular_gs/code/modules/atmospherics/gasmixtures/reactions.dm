/datum/gas_reaction/lipoifium_formation
	priority_group = PRIORITY_FORMATION
	name = "Lipoifium Formation"
	id = "lipoifium_formation"
	desc = "Plasma has characteristics similar to hydrocarbons. Cooling it with tritium around causes the creation of a highly fattening gas."

/datum/gas_reaction/lipoifium_formation/init_reqs()
	requirements = list(
		"MAX_TEMP" = 100,
		/datum/gas/plasma = MINIMUM_MOLE_COUNT,
		/datum/gas/tritium = MINIMUM_MOLE_COUNT,
	)

/datum/gas_reaction/lipoifium_formation/react(datum/gas_mixture/air, datum/holder)
	var/list/cached_moles = air.moles
	var/plasma_moles = cached_moles[/datum/gas/plasma]
	var/tritium_moles = cached_moles[/datum/gas/tritium]
	if (plasma_moles < MINIMUM_MOLE_COUNT || tritium_moles < MINIMUM_MOLE_COUNT)
		return NO_REACTION

	var/temperature = air.temperature
	var/reaction_efficiency = 0
	if (temperature <= 5)
		reaction_efficiency = 1
	else if (temperature >= 100)
		return NO_REACTION
	else
		reaction_efficiency = -((temperature - 5) / 95) + 1		// will equal 1 at 5 kelvin, and will linearly fall until 0 at 100k

	var/old_heat_capacity = air.heat_capacity()

	var/used_moles = min((reaction_efficiency * min(plasma_moles, tritium_moles) * 0.5), 10)
	var/energy_released = used_moles * FIRE_CARBON_ENERGY_RELEASED

	cached_moles[/datum/gas/lipoifium] += used_moles
	cached_moles[/datum/gas/plasma] -= used_moles
	cached_moles[/datum/gas/tritium] -= used_moles
	var/new_heat_capacity = air.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air.temperature = (max((temperature * old_heat_capacity + energy_released) / new_heat_capacity, TCMB))

	return REACTING

/datum/gas_reaction/galbanium_formation
	priority_group = PRIORITY_FORMATION
	name = "Galbanium Formation"
	id = "galbanium_formation"
	desc = "Enriching lipoifium with BZ drastically changes the way in which it affects people inhaling it."

/datum/gas_reaction/galbanium_formation/init_reqs()
	requirements = list(
		"MIN_TEMP" = 5000,
		/datum/gas/lipoifium = MINIMUM_MOLE_COUNT,
		/datum/gas/bz = MINIMUM_MOLE_COUNT,
	)

/datum/gas_reaction/galbanium_formation/react(datum/gas_mixture/air, datum/holder)
	var/list/cached_moles = air.moles
	var/lipoifium_moles = cached_moles[/datum/gas/lipoifium]
	var/bz_moles = cached_moles[/datum/gas/bz]
	if (lipoifium_moles < MINIMUM_MOLE_COUNT || bz_moles < MINIMUM_MOLE_COUNT)
		return NO_REACTION

	var/temperature = air.temperature
	var/reaction_efficiency = 0
	if (temperature > 10000)
		reaction_efficiency = 1
	else if (temperature < 5000)
		return NO_REACTION
	else
		reaction_efficiency = (temperature / 5000) - 1

	var/old_heat_capacity = air.heat_capacity()

	var/used_moles = min((reaction_efficiency * min(lipoifium_moles, bz_moles) * 0.5), 10)
	var/consumed = used_moles * FIRE_CARBON_ENERGY_RELEASED / 2

	cached_moles[/datum/gas/galbanium] += used_moles
	cached_moles[/datum/gas/lipoifium] -= used_moles
	cached_moles[/datum/gas/bz] -= used_moles
	var/new_heat_capacity = air.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air.temperature = (max((temperature * old_heat_capacity - consumed) / new_heat_capacity, TCMB))

	return REACTING
