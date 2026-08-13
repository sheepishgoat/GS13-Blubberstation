/datum/wires/airlock/get_status()
	. = ..()
	var/obj/machinery/door/airlock/airlock = holder
	. += "The weight scan light is [airlock.check_fatness ? "on" : "off"]."

/datum/wires/airlock/on_pulse(wire)
	var/obj/machinery/door/airlock/airlock = holder
	if (wire == WIRE_WEIGHT_SCAN)
		airlock.check_fatness = !airlock.check_fatness
		return
	
	return ..()

/datum/wires/airlock/on_cut(wire, mend, source)
	var/obj/machinery/door/airlock/airlock = holder
	if (wire == WIRE_WEIGHT_SCAN)
		airlock.check_fatness = FALSE
		airlock.fatness_to_check = 0
		return
	
	return ..()
