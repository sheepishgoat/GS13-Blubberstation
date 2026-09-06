/obj/item/organ/stomach/proc/handle_gaining_weight(mob/living/carbon/human/human, nutrition, seconds_per_tick)
	if(nutrition > NUTRITION_LEVEL_FULL)
		var/nutrition_that_becomes_fat = (nutrition - NUTRITION_LEVEL_FULL) * NUTRITION_CONVERSION_EFFICIENCY
		human.adjust_nutrition(-nutrition_that_becomes_fat, TRUE) // Force adjust_nutrition to happen ignoring TRAIT_NOHUNGER
		human.adjust_fatness(nutrition_that_becomes_fat * NUTRITION_TO_FAT_RATIO, FATTENING_TYPE_FOOD)
	
	// it pains me to do this on the stomach but this has to be done
	human.handle_calorite_poisoning(seconds_per_tick)
	human.handle_fullness_alert()
