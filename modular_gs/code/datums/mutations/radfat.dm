/datum/mutation/radfat
	name = "Radiotrophic Metabolism"
	desc = "A mutation that causes the user to be immune to the adverse effects of radiations, but causes sudden cell multiplication with increased strength under irradiation."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You crave the taste of... radiation?</span>"
	text_lose_indication = "<span class='notice'>You no longer desire the taste of radiation...</span>"
	difficulty = 10
	instability = 30
	/// How much fat to add per second. Multiplied by the brightness level of the turf the owner is on
	var/fat_to_add = 1

/datum/mutation/radfat/on_life(seconds_per_tick)
	var/light_level = get_light_level()
	// light is also a type of radiation
	owner.adjust_fatness(fat_to_add * light_level * seconds_per_tick, FATTENING_TYPE_MUTATIONS)

/datum/mutation/radfat/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_RADRESONANCE, "radfat_mutation")

/datum/mutation/radfat/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	REMOVE_TRAIT(owner, TRAIT_RADRESONANCE, "radfat_mutation")

/datum/mutation/radfat/proc/get_light_level()
	var/light_amount = 0
	if(isturf(owner.loc)) //else, there's considered to be no light
		var/turf/host_turf = owner.loc
		light_amount = host_turf.get_lumcount()
		if(light_amount >= SHADOW_SPECIES_LIGHT_THRESHOLD)
			return light_amount
	
	return 0

/obj/item/dnainjector/antiradfat
	name = "\improper DNA injector (Anti-Radiotrophic Metabolism)"
	desc = "The green kills."
	remove_mutations = list(/datum/mutation/radfat)

/obj/item/dnainjector/radfat
	name = "\improper DNA injector (Radiotrophic Metabolism)"
	desc = "Nuclear fallout protection at an heavy price."
	add_mutations = list(/datum/mutation/radfat)
