/datum/helplessness/immobile
	helplessness_trait = TRAIT_NO_MOVE
	default_trigger_weight = FATNESS_LEVEL_IMMOBILE
	override_quirk = TRAIT_HELPLESS_IMMOBILITY
	preference = /datum/preference/numeric/helplessness/no_movement
	gain_message = "You have become too fat to move anymore."
	lose_message = "You have become thin enough to regain some of your mobility."

/datum/helplessness/immobile/get_trigger_weight(mob/living/carbon/human/fatty)
	var/datum/preferences/preferences = fatty.client.prefs

	var/trigger_weight = preferences.read_preference(preference.type)

	if (HAS_TRAIT(fatty, override_quirk))
		trigger_weight = default_trigger_weight
		if (HAS_TRAIT(fatty, TRAIT_STRONGLEGS))
			trigger_weight = FATNESS_LEVEL_BLOB
		if (HAS_TRAIT(fatty, TRAIT_WEAKLEGS))
			trigger_weight = FATNESS_LEVEL_BARELYMOBILE
	
	return trigger_weight

/datum/helplessness/clumsy
	helplessness_trait = TRAIT_CLUMSY
	default_trigger_weight = FATNESS_LEVEL_BARELYMOBILE
	override_quirk = TRAIT_HELPLESS_CLUMSY
	preference = /datum/preference/numeric/helplessness/clumsy
	gain_message = "Your newfound weight has made it hard to manipulate objects."
	lose_message = "You feel like you have lost enough weight to recover your dexterity."

/datum/helplessness/clumsy/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	var/should_be_active = .

	if (should_be_active)
		if (!HAS_TRAIT_FROM(fatty, TRAIT_CHUNKYFINGERS, HELPLESSNESS_TRAIT))
			ADD_TRAIT(fatty, TRAIT_CHUNKYFINGERS, HELPLESSNESS_TRAIT)
	else
		if (HAS_TRAIT_FROM(fatty, TRAIT_CHUNKYFINGERS, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_CHUNKYFINGERS, HELPLESSNESS_TRAIT)
	
	return should_be_active

/datum/helplessness/nearsighted
	helplessness_trait = 0	// nearsighted isn't a trait the same way others are
	default_trigger_weight = FATNESS_LEVEL_BLOB
	override_quirk = TRAIT_HELPLESS_BIG_CHEEKS
	preference = /datum/preference/numeric/helplessness/nearsighted
	gain_message = "Your fat makes it difficult to see the world around you."
	lose_message = "You are thin enough to see your environment again."

/datum/helplessness/nearsighted/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	if (trigger_weight <= 0)
		fatty.cure_nearsighted(HELPLESSNESS_TRAIT)
		return FALSE

	if (!fatty.is_nearsighted_from(HELPLESSNESS_TRAIT))
		if (fatness >= trigger_weight)
			to_chat(fatty, span_warning(gain_message))
			fatty.become_nearsighted(HELPLESSNESS_TRAIT)
			return TRUE
		return FALSE
		
	else if (fatness < trigger_weight)
		to_chat(fatty, span_notice(lose_message))
		fatty.cure_nearsighted(HELPLESSNESS_TRAIT)
		return FALSE
	
	return TRUE

/datum/helplessness/hidden_face
	helplessness_trait = TRAIT_DISFIGURED
	default_trigger_weight = FATNESS_LEVEL_BLOB
	override_quirk = TRAIT_HELPLESS_BIG_CHEEKS
	preference = /datum/preference/numeric/helplessness/hidden_face
	gain_message = "You have gotten so fat that your face is now unrecognizable."
	lose_message = "You have lost enough weight to allow people to recognize your face."

/datum/helplessness/mute
	helplessness_trait = TRAIT_MUTE
	default_trigger_weight = FATNESS_LEVEL_BLOB
	override_quirk = TRAIT_HELPLESS_MUTE
	preference = /datum/preference/numeric/helplessness/mute
	gain_message = "Your fat makes it impossible for you to speak."
	lose_message = "You are thin enough now to be able to speak again."

/datum/helplessness/immobile_arms
	helplessness_trait = TRAIT_PARALYSIS_L_ARM	// one arm, because we can't do 2 at once, and we want to be able to use the default apply_helplessness
	default_trigger_weight = FATNESS_LEVEL_BLOB
	override_quirk = TRAIT_HELPLESS_IMMOBILE_ARMS
	preference = /datum/preference/numeric/helplessness/immobile_arms
	gain_message = "Your arms are now engulfed in fat, making it impossible to move your arms."
	lose_message = "You are able to move your arms again."

/datum/helplessness/immobile_arms/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	var/should_be_active = .

	if (should_be_active)
		if (!HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT))
			ADD_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_body_parts()
	else
		if (HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_body_parts()
	
	return should_be_active

/datum/helplessness/jumpsuit_bursting
	helplessness_trait = TRAIT_NO_JUMPSUIT
	default_trigger_weight = FATNESS_LEVEL_IMMOBILE
	override_quirk = TRAIT_HELPLESS_CLOTHING
	preference = /datum/preference/numeric/helplessness/clothing_jumpsuit
	gain_message = "You feel too fat to wear jumpsuits."
	lose_message = "You feel thin enough to put on jumpsuits now."

/datum/helplessness/jumpsuit_bursting/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	// the super function to this returns true if the helplessness mechanic is active, and false otherwise
	var/should_be_active = .

	if (!should_be_active)
		return should_be_active
	
	var/obj/item/clothing/under/jumpsuit = fatty.w_uniform
	if(istype(jumpsuit) && jumpsuit.modular_icon_location == null)
		to_chat(fatty, span_warning("[jumpsuit] can no longer contain your weight!"))
		fatty.dropItemToGround(jumpsuit)
	
	return should_be_active

/datum/helplessness/misc_clothing_bursting
	helplessness_trait = TRAIT_NO_MISC
	default_trigger_weight = FATNESS_LEVEL_BARELYMOBILE
	override_quirk = TRAIT_HELPLESS_CLOTHING
	preference = /datum/preference/numeric/helplessness/clothing_misc
	gain_message = "You feel too fat to wear suits, shoes, and gloves."
	lose_message = "You feel thin enough to put on suits, shoes, and gloves now."

/datum/helplessness/misc_clothing_bursting/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	// the super function to this returns true if the helplessness mechanic is active, and false otherwise
	var/should_be_active = .

	if (!should_be_active)
		return should_be_active
	
	var/obj/item/clothing/suit/worn_suit = fatty.wear_suit
	if(istype(worn_suit) && !istype(worn_suit, /obj/item/clothing/suit/mod))
		to_chat(fatty, span_warning("[worn_suit] can no longer contain your weight!"))
		fatty.dropItemToGround(worn_suit)

	var/obj/item/clothing/gloves/worn_gloves = fatty.gloves
	if(istype(worn_gloves)&& !istype(worn_gloves, /obj/item/clothing/gloves/mod))
		to_chat(fatty, span_warning("[worn_gloves] can no longer contain your weight!"))
		fatty.dropItemToGround(worn_gloves)

	var/obj/item/clothing/shoes/worn_shoes = fatty.shoes
	if(istype(worn_shoes) && !istype(worn_shoes, /obj/item/clothing/shoes/mod))
		to_chat(fatty, span_warning("[worn_shoes] can no longer contain your weight!"))
		fatty.dropItemToGround(worn_shoes)
	
	return should_be_active

/datum/helplessness/belt_bursting	// my beloved
	helplessness_trait = TRAIT_NO_BELT
	default_trigger_weight = FATNESS_LEVEL_EXTREMELY_OBESE
	override_quirk = TRAIT_HELPLESS_BELTS
	preference = /datum/preference/numeric/helplessness/belts
	gain_message = "You feel too fat to wear belts."
	lose_message = "You feel thin enough to put on belts now."

/datum/helplessness/belt_bursting/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	var/should_be_active = .

	if (!should_be_active)
		return should_be_active

	var/obj/item/bluespace_belt/primitive/PBS_belt = fatty.belt
	if(istype(PBS_belt) && fatness > trigger_weight)
		fatty.visible_message(span_warning("[PBS_belt] fails as it's unable to contain [fatty]'s bulk!"),
		span_warning("[PBS_belt] fails as it's unable to contain your bulk!"))
		fatty.dropItemToGround(PBS_belt)

	var/obj/item/storage/belt/belt = fatty.belt
	if(istype(belt))
		fatty.visible_message(
			span_warning("With a loud ripping sound, [fatty]'s [belt] snaps open!"),
			span_warning("With a loud ripping sound, your [belt] snaps open!"))
		fatty.dropItemToGround(belt)
	
	return should_be_active

/datum/helplessness/back_clothing
	helplessness_trait = TRAIT_NO_BACKPACK
	default_trigger_weight = FATNESS_LEVEL_IMMOBILE
	override_quirk = TRAIT_HELPLESS_BACKPACKS
	preference = /datum/preference/numeric/helplessness/clothing_back
	gain_message = "You feel too fat to wear backpacks."
	lose_message = "You feel thin enough to hold items on your back now."

/datum/helplessness/back_clothing/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	var/should_be_active = .

	if (!should_be_active)
		return should_be_active

	var/obj/item/back_item = fatty.back
	if(istype(back_item) && !istype(back_item, /obj/item/mod))
		to_chat(fatty, span_warning("Your weight makes it impossible for you to carry [back_item]."))
		fatty.dropItemToGround(back_item)
	
	return should_be_active

/datum/helplessness/no_buckle
	helplessness_trait = TRAIT_NO_BUCKLE
	default_trigger_weight = FATNESS_LEVEL_EXTREMELY_OBESE
	override_quirk = TRAIT_HELPLESS_NO_BUCKLE
	preference = /datum/preference/numeric/helplessness/no_buckle
	gain_message = "You feel like you've gotten too big to fit on anything."
	lose_message = "You feel thin enough to sit on things again."
