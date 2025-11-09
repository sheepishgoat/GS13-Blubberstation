// /datum/quirk/bed_blob
// 	name = "Bed Blob"
// 	desc = "You make for a great bed! After reaching blob weight stage, other people will be able to buckle themselves on top of you!"
// 	icon = "fa-weight-hanging"
// 	// medical_record_text = "Patients legs cannot carry heavy weights well."
// 	value = 0
// 	// gain_text = span_notice("You feel your legs tremble under your weight")
// 	// lose_text = span_notice("Your legs seem to have gotten stronger")
// 	quirk_flags = QUIRK_HIDE_FROM_SCAN
// 	erp_quirk = FALSE
// 	// mob_trait = TRAIT_HELPLESS_IMMOBILITY

/datum/quirk/fat_temperature_resistance
	name = "Natural insulation"
	desc = "All that heft you carry around keeps you nice and warm! You are less affected by temperatures depending on your weight."
	icon = "fa-weight-hanging"
	// medical_record_text = "Patients legs cannot carry heavy weights well."
	value = 2
	// gain_text = span_notice("You feel your legs tremble under your weight")
	// lose_text = span_notice("Your legs seem to have gotten stronger")
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES
	erp_quirk = FALSE
	// mob_trait = TRAIT_HELPLESS_IMMOBILITY
	var/heat_resistance = 0
	var/cold_resistance = 0

/datum/quirk/fat_temperature_resistance/process(seconds_per_tick)
	// make sure it has fatness
	// if (!iscarbon(quirk_holder))
	// 	return

	var/mob/living/carbon/human/fatty = quirk_holder

	// remove old resistances
	fatty.dna.species.bodytemp_heat_damage_limit -= heat_resistance
	fatty.dna.species.bodytemp_cold_damage_limit += cold_resistance

	// calc new ones
	var/temperature_resistance = 20 * (fatty.fatness - FATNESS_LEVEL_VERYFAT) / FATNESS_LEVEL_EXTREMELY_OBESE
	heat_resistance = clamp(temperature_resistance, 0, 20)
	cold_resistance = clamp(temperature_resistance, 0, 20)

	if (temperature_resistance >= 20)
		ADD_TRAIT(fatty, TRAIT_RESISTCOLD, TRAIT_FAT_TEMPERATURE)

	// apply new ones
	fatty.dna.species.bodytemp_heat_damage_limit += heat_resistance
	fatty.dna.species.bodytemp_cold_damage_limit -= cold_resistance

// /datum/quirk/fast_metabolism
// 	name = "Fast metabolism"
// 	desc = "You process calories much faster than others. While walking under your own strength, you will lose some of your weight over time."
// 	icon = "fa-weight-hanging"
// 	// medical_record_text = "Patients legs cannot carry heavy weights well."
// 	value = 1
// 	// gain_text = span_notice("You feel your legs tremble under your weight")
// 	// lose_text = span_notice("Your legs seem to have gotten stronger")
// 	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN
// 	erp_quirk = FALSE
// 	// mob_trait = TRAIT_HELPLESS_IMMOBILITY

/datum/quirk/helplessness/nutricious_boost
	name = "Nutricious boost"
	desc = "All that caloric food is full of energy, and you're great at making good use of it. You get a speed boost while digesting food. WARNING! TAKING THIS QUIRK WILL LOCK YOUR CHARACTER INTO WG MECHANICS!"
	icon = "fa-weight-hanging"
	medical_record_text = "Patients seems to gain a noticeable speed boost after meals."
	value = 4
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN
	erp_quirk = FALSE
	mob_trait = TRAIT_NUTRICIOUS_BOOST

/datum/movespeed_modifier/nutricious_boost
	blacklisted_movetypes = (FLYING|FLOATING)
	// multiplicative_slowdown = -0.5
	conflicts_with = TRAIT_NUTRICIOUS_BOOST

/datum/movespeed_modifier/nutricious_boost/nutriment	// not actually implemented, we need to have WG from food first...
	multiplicative_slowdown = -0.3

/datum/movespeed_modifier/nutricious_boost/lipoifier
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/nutricious_boost/galbanic
	multiplicative_slowdown = -0.8

/datum/quirk/strong_legs
	name = "Strong legs"
	desc = "Your legs are used to carrying heavy loads. Being fat slows you down less. You can still become immobile, though."
	icon = "fa-bone"
	medical_record_text = "Patients legs can carry heavy weights well."
	value = 1
	gain_text = span_notice("Your legs seem to have gotten stronger")
	lose_text = span_notice("You feel your legs tremble under your weight")
	quirk_flags = 0
	erp_quirk = FALSE
	mob_trait = TRAIT_STRONGLEGS

/datum/quirk/nutriment_immune_system
	name = "Surplus nutrients"
	desc = "Having this much excess calories gives your immune system quite the beefy defense budget! You are less likely to contract diseases and infections depending on weight."
	icon = "fa-virus"
	medical_record_text = "Patients immune system benefits greatly from having excess calories available."
	value = 3
	quirk_flags = QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES
	erp_quirk = FALSE
	mob_trait = TRAIT_SURPLUS_NUTRIENTS

/datum/quirk/nutriment_immune_system/process(seconds_per_tick)
	// make sure it has fatness
	if (!iscarbon(quirk_holder))
		return

	var/mob/living/carbon/fatty = quirk_holder

	// check their weight and apply virus resistance if they're fat
	if (fatty.fatness >= FATNESS_LEVEL_FATTER)
		ADD_TRAIT(quirk_holder, TRAIT_VIRUS_RESISTANCE, TRAIT_SURPLUS_NUTRIENTS)
		return
	// if we're here it means we haven't returned, meaning we aren't fat enough. Go eat more.
	REMOVE_TRAIT(quirk_holder, TRAIT_VIRUS_RESISTANCE, TRAIT_SURPLUS_NUTRIENTS)

/datum/quirk/fat_health
	name = "Naturally padded"
	desc = "All that bulk you're carrying around is great at softening blows. You are slightly more resistant to damage depending on your weight."
	icon = "fa-shield"
	value = 5
	gain_text = span_notice("You feel like a tank!")
	lose_text = span_notice("Your no longer feel like a 60 ton armored behemoth.")
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_HIDE_FROM_SCAN | QUIRK_PROCESSES
	erp_quirk = FALSE
	mob_trait = TRAIT_NATURALLY_PADDED
	var/damage_resistance = 1

/datum/quirk/fat_health/process(seconds_per_tick)
	// make sure it's a human
	// if(!ishuman(quirk_holder))
	// 	return

	var/mob/living/carbon/human/fatty = quirk_holder

	// remove old modifier
	fatty.physiology.brute_mod *= damage_resistance
	fatty.physiology.tox_mod *= damage_resistance

	// calc the new one
	damage_resistance = 1 + ((fatty.fatness - FATNESS_LEVEL_VERYFAT) / (FATNESS_LEVEL_BLOB - FATNESS_LEVEL_VERYFAT)) // we divide by (FATNESS_LEVEL_BLOB - FATNESS_LEVEL_VERYFAT) so that at FATNESS_LEVEL_BLOB the expression equals 2
	damage_resistance = clamp(damage_resistance, 1, 2)

	// apply the new one
	fatty.physiology.brute_mod /= damage_resistance
	fatty.physiology.tox_mod /= damage_resistance

/datum/quirk/slime_eater
	name = "Slime eater"
	desc = "Slimes make your mouth water! You can safely metabolize slime jelly for nutrition and can gobble up a xenobiology slime you are aggressively grabbing!"
	icon = "fa-shield"
	value = 1
	gain_text = span_notice("You are hungry for slime! Yummy!")
	lose_text = span_notice("You no longer feel hungry for slimes. Yuck...")
