//GS13 weight gain drinks

/datum/reagent/consumable/ethanol/belly_bloats
	name = "Belly Bloats"
	description = "A classic of this sector that bloats the waistline. Hard to stop chugging once you start."
	color = "#FF3333"
	boozepwr = 25
	taste_description = "a heavy mix of cherry and beer"
	quality = DRINK_GOOD

/datum/glass_style/drinking_glass/belly_bloats
	required_drink_type = /datum/reagent/consumable/ethanol/belly_bloats
	name = "belly bloats"
	desc = "The perfect mix to be big and merry with."
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "belly_bloats"

/datum/reagent/consumable/ethanol/belly_bloats/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food)) // GS13
		M.nutrition += 15 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/ethanol/blobby_mary
	name = "Blobby Mary"
	description = "A bloody mary that may make you immobile. Still wondering if it's blood or tomato juice?"
	color = "#C2707E"
	boozepwr = 55
	taste_description = "tomateos and an anvil on your stomach"
	quality = DRINK_FANTASTIC

/datum/glass_style/drinking_glass/blobby_mary
	required_drink_type = /datum/reagent/consumable/ethanol/blobby_mary
	name = "blobby mary"
	desc = "For the morbidly obese ladies and gentlemen."
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "blobby_mary"

/datum/reagent/consumable/ethanol/blobby_mary/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food)) // GS13
		M.nutrition += 25 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/ethanol/beltbuster_mead
	name = "Beltbuster Mead"
	description = "Kiss sobriety and clothes goodbye."
	color = "#664300"
	boozepwr = 85
	taste_description = "honey, alcohol and immobility"
	quality = DRINK_FANTASTIC

/datum/glass_style/drinking_glass/beltbuster_mead
	required_drink_type = /datum/reagent/consumable/ethanol/beltbuster_mead
	name = "beltbuster mead"
	desc = "The ambrosia of the blubbery gods."
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "beltbuster_mead"

/datum/reagent/consumable/ethanol/beltbuster_mead/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food)) // GS13
		M.nutrition += 30 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/heavy_cafe
	name = "Heavy Cafe"
	description = "Coffee, milk, sugar and cream. For the days when you really don't want to work."
	color = "#663300"
	taste_description = "coffee, milk and sugar"
	quality = DRINK_GOOD
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/glass_style/drinking_glass/heavy_cafe
	required_drink_type = /datum/reagent/consumable/heavy_cafe
	name = "heavy cafe"
	desc = "To enjoy slow mornings with."
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "heavy_cafe"

/datum/reagent/consumable/heavy_cafe/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	. = ..()
	M.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	M.adjust_drowsiness(-12 SECONDS * REM * seconds_per_tick)
	var/need_mob_update
	need_mob_update = M.SetSleeping(0)
	M.adjust_bodytemperature(5 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, M.get_body_temp_normal())
	if(M.getBruteLoss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += M.heal_bodypart_damage(brute = 1 * REM * seconds_per_tick, burn = 0, updating_health = FALSE)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food)) // GS13
		M.nutrition += 15 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/fruits_tea
	name = "Fruits Tea"
	description = "Somehow this mix of fruits and tea can cause considerable bulking."
	color = "#FFCC33"
	taste_description = "a sweet and sour mix"
	quality = DRINK_NICE

/datum/glass_style/drinking_glass/fruits_tea
	required_drink_type = /datum/reagent/consumable/fruits_tea
	name = "fruits tea"
	desc = "Goes down really easy and stays there for a long time."
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "fruits_tea"

/datum/reagent/consumable/fruits_tea/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.adjust_dizzy(-4 SECONDS * REM * seconds_per_tick)
	M.adjust_drowsiness(-4 SECONDS * REM * seconds_per_tick)
	M.adjust_jitter(-6 SECONDS * REM * seconds_per_tick)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food)) // GS13
		M.nutrition += 15 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()
	. = 1

/datum/reagent/consumable/snakebite
	name = "Snakebite"
	description = "Guaranteed to stop 100% of all moving."
	color = "#00CC33"
	taste_description = "bitter immobility"
	quality = DRINK_VERYGOOD

/datum/glass_style/drinking_glass/snakebite
	required_drink_type = /datum/reagent/consumable/snakebite
	name = "snakebite"
	desc = "Won't hurt like a real bite, but you'll still regret drinking this."
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "snakebite"

/datum/reagent/consumable/snakebite/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_food)) // GS13
		M.nutrition += 25 * REAGENTS_METABOLISM
	else
		M.nutrition += 1
	..()

/datum/reagent/consumable/milkshake_vanilla
	name = "Vanilla Milkshake"
	description = "A plain vanilla milkshake. A classic."
	color = "#DFDFDF"
	taste_description = "creamy vanilla"
	quality = DRINK_VERYGOOD
	nutriment_factor = 6 * REAGENTS_METABOLISM

/datum/glass_style/drinking_glass/milkshake_vanilla
	required_drink_type = /datum/reagent/consumable/milkshake_vanilla
	name = "vanilla milkshake"
	desc = "Guess they fixed the milkshake machine after all, huh?"
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "vanilla_milkshake"

/datum/reagent/consumable/milkshake_chocolate
	name = "Chocolate Milkshake"
	description = "It's like chocolate milk, but for even cooler kids."
	color = "#7D4E29"
	taste_description = "creamy chocolate"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8 * REAGENTS_METABOLISM

/datum/glass_style/drinking_glass/milkshake_chocolate
	required_drink_type = /datum/reagent/consumable/milkshake_chocolate
	name = "chocolate milkshake"
	desc = "Nothing better than cream AND cocoa!"
	icon = 'modular_gs/icons/obj/drinks.dmi'
	icon_state = "milkshake_chocolate"
