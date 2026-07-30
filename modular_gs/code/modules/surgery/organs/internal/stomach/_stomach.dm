/obj/item/organ/stomach/proc/handle_gaining_weight(mob/living/carbon/human/human, nutrition)
	if(nutrition > NUTRITION_LEVEL_FULL)
		// fatConversionRate is functionally useless. It seems under normal curcumstances, each tick only processes, at most, 1 nutrition anyway. reducing the value has no effect.
		var/fatConversionRate = 250 // what percentage of the excess nutrition should go to fat (total nutrition to transfer can't be under 1)
		var/nutritionThatBecomesFat = max((nutrition - NUTRITION_LEVEL_FULL)*(fatConversionRate / 100),1)
		human.adjust_nutrition(-nutritionThatBecomesFat, TRUE) // Force adjust_nutrition to happen ignoring TRAIT_NOHUNGER
		human.adjust_fatness(nutritionThatBecomesFat, FATTENING_TYPE_FOOD)
	
	// it pains me to do this on the stomach but this has to be done
	human.handle_calorite_poisoning()
	human.handle_fullness_alert()
