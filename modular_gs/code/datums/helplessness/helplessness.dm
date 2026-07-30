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
		if (HAS_TRAIT(fatty, TRAIT_WEAKLEGS))
			trigger_weight = FATNESS_LEVEL_BARELYMOBILE

	return trigger_weight

/datum/helplessness/clumsy
	helplessness_trait = TRAIT_CHUNKYFINGERS
	default_trigger_weight = FATNESS_LEVEL_BARELYMOBILE
	override_quirk = TRAIT_HELPLESS_CLUMSY
	preference = /datum/preference/numeric/helplessness/clumsy
	gain_message = "Your newfound weight has made it hard to manipulate objects."
	lose_message = "You feel like you have lost enough weight to recover your dexterity."

/datum/helplessness/low_fov
	helplessness_trait = null
	default_trigger_weight = FATNESS_LEVEL_BLOB
	override_quirk = TRAIT_HELPLESS_BIG_CHEEKS
	preference = /datum/preference/numeric/helplessness/low_fov
	gain_message = "Your fat makes it difficult to see the world around you."
	lose_message = "You are thin enough to see your environment better."

/datum/helplessness/low_fov/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	if(fatness >= 2 * trigger_weight)
		if(!HAS_TRAIT(fatty, TRAIT_VERY_LOW_FOV))
			to_chat(fatty, span_warning(gain_message))
			ADD_TRAIT(fatty, TRAIT_VERY_LOW_FOV, HELPLESSNESS_TRAIT)
			REMOVE_TRAIT(fatty, TRAIT_LOW_FOV, HELPLESSNESS_TRAIT)
			fatty.add_fov_trait(TRAIT_LOW_FOV, FOV_270_DEGREES)
			return TRUE

		return FALSE

	if(!HAS_TRAIT(fatty, TRAIT_LOW_FOV))
		to_chat(fatty, span_warning(gain_message))
		ADD_TRAIT(fatty, TRAIT_LOW_FOV, HELPLESSNESS_TRAIT)
		REMOVE_TRAIT(fatty, TRAIT_VERY_LOW_FOV, HELPLESSNESS_TRAIT)
		fatty.add_fov_trait(TRAIT_LOW_FOV, FOV_180_DEGREES)
		return TRUE

	return FALSE

/datum/helplessness/low_fov/disable_helplessness(mob/living/carbon/human/fatty)
	fatty.remove_fov_trait(TRAIT_VERY_LOW_FOV, FOV_270_DEGREES)
	fatty.remove_fov_trait(TRAIT_LOW_FOV, FOV_180_DEGREES)
	REMOVE_TRAIT(fatty, TRAIT_VERY_LOW_FOV, HELPLESSNESS_TRAIT)
	REMOVE_TRAIT(fatty, TRAIT_LOW_FOV, HELPLESSNESS_TRAIT)
	return TRUE

/datum/helplessness/nearsighted
	helplessness_trait = TRAIT_NEARSIGHTED
	default_trigger_weight = FATNESS_LEVEL_BLOB
	override_quirk = TRAIT_HELPLESS_NEARSIGHTED
	preference = /datum/preference/numeric/helplessness/nearsighted
	gain_message = "Your fat makes it difficult to see the world around you."
	lose_message = "You are thin enough to see your environment better."

/datum/helplessness/nearsighted/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	if (.)
		fatty.become_nearsighted(HELPLESSNESS_TRAIT)

/datum/helplessness/nearsighted/disable_helplessness(mob/living/carbon/human/fatty)
	. = ..()
	if (.)
		fatty.cure_nearsighted(HELPLESSNESS_TRAIT)

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
	var/activated = .

	if (activated)
		ADD_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
		fatty.update_body_parts()

/datum/helplessness/immobile_arms/disable_helplessness(mob/living/carbon/human/fatty)
	. = ..()
	var/disabled_helplessness = .

	if (disabled_helplessness)
		REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
		fatty.update_body_parts()

/datum/helplessness/jumpsuit_bursting
	helplessness_trait = TRAIT_NO_JUMPSUIT
	default_trigger_weight = FATNESS_LEVEL_IMMOBILE
	override_quirk = TRAIT_HELPLESS_CLOTHING
	preference = /datum/preference/numeric/helplessness/clothing_jumpsuit
	gain_message = "You feel too fat to wear jumpsuits."
	lose_message = "You feel thin enough to put on jumpsuits now."

/datum/helplessness/jumpsuit_bursting/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	..()

	var/obj/item/clothing/under/jumpsuit = fatty.w_uniform
	if(istype(jumpsuit))
		to_chat(fatty, span_warning("[jumpsuit] can no longer contain your weight!"))
		fatty.dropItemToGround(jumpsuit)

/datum/helplessness/misc_clothing_bursting
	helplessness_trait = TRAIT_NO_MISC
	default_trigger_weight = FATNESS_LEVEL_BARELYMOBILE
	override_quirk = TRAIT_HELPLESS_CLOTHING
	preference = /datum/preference/numeric/helplessness/clothing_misc
	gain_message = "You feel too fat to wear suits, shoes, and gloves."
	lose_message = "You feel thin enough to put on suits, shoes, and gloves now."

/datum/helplessness/misc_clothing_bursting/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()

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

/datum/helplessness/belt_bursting	// my beloved
	helplessness_trait = TRAIT_NO_BELT
	default_trigger_weight = FATNESS_LEVEL_EXTREMELY_OBESE
	override_quirk = TRAIT_HELPLESS_BELTS
	preference = /datum/preference/numeric/helplessness/belts
	gain_message = "You feel too fat to wear belts."
	lose_message = "You feel thin enough to put on belts now."

/datum/helplessness/belt_bursting/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()

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

/datum/helplessness/back_clothing
	helplessness_trait = TRAIT_NO_BACKPACK
	default_trigger_weight = FATNESS_LEVEL_IMMOBILE
	override_quirk = TRAIT_HELPLESS_BACKPACKS
	preference = /datum/preference/numeric/helplessness/clothing_back
	gain_message = "You feel too fat to wear backpacks."
	lose_message = "You feel thin enough to hold items on your back now."

/datum/helplessness/back_clothing/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()

	var/obj/item/back_item = fatty.back
	if(istype(back_item) && !istype(back_item, /obj/item/mod))
		to_chat(fatty, span_warning("Your weight makes it impossible for you to carry [back_item]."))
		fatty.dropItemToGround(back_item)

/datum/helplessness/no_buckle
	helplessness_trait = TRAIT_NO_BUCKLE
	default_trigger_weight = FATNESS_LEVEL_EXTREMELY_OBESE
	override_quirk = TRAIT_HELPLESS_NO_BUCKLE
	preference = /datum/preference/numeric/helplessness/no_buckle
	gain_message = "You feel like you've gotten too big to fit on anything."
	lose_message = "You feel thin enough to sit on things again."

/datum/helplessness/no_neck
	helplessness_trait = TRAIT_NO_NECK
	default_trigger_weight = FATNESS_LEVEL_BLOB
	override_quirk = TRAIT_HELPLESS_THICK_NECK
	preference = /datum/preference/numeric/helplessness/no_neck
	gain_message = "You feel a tightness around your neck."
	lose_message = "You no longer feel a tightness around your neck."

/datum/helplessness/no_neck/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()

	var/obj/item/clothing/neck/neckwear = fatty.wear_neck
	if(istype(neckwear))
		to_chat(fatty, span_warning("[neckwear] can no longer fit around your neck!"))
		fatty.dropItemToGround(neckwear)

/datum/helplessness/waddle
	helplessness_trait = TRAIT_WADDLE
	default_trigger_weight = FATNESS_LEVEL_BARELYMOBILE
	override_quirk = TRAIT_HELPLESS_WADDLING
	preference = /datum/preference/numeric/helplessness/waddle
	gain_message = "Your legs are too thick to walk straight."
	lose_message = "Your legs are thin enough to walk normally again."

/datum/helplessness/waddle/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	if (!.)
		return
	fatty.AddElementTrait(TRAIT_WADDLING, REF(fatty), /datum/element/waddling)

/datum/helplessness/waddle/disable_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	if (!.)
		return
	REMOVE_TRAIT(fatty, TRAIT_WADDLING, REF(fatty))

/datum/helplessness/lisp
	helplessness_trait = TRAIT_LISP
	default_trigger_weight = FATNESS_LEVEL_BARELYMOBILE
	override_quirk = TRAIT_HELPLESS_LISP
	preference = /datum/preference/numeric/helplessness/lisp
	gain_message = "Your face feelth too big to pronouce thome letterth."
	lose_message = "Your face has shrunk enough to talk normally again."

/datum/helplessness/lisp/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	if (!.)
		return
	RegisterSignal(fatty, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/helplessness/lisp/disable_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	if (!.)
		return
	UnregisterSignal(fatty, COMSIG_MOB_SAY)

/datum/helplessness/lisp/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(HAS_TRAIT(source, TRAIT_SIGN_LANG))
		return
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		message = replacetext(message,"s","th")
		message = replacetext(message,"x","th")
		speech_args[SPEECH_MESSAGE] = message

#define MAX_PRESSURE_DEBUFF 0.5
/*
/datum/helplessness/weak_lungs
	helplessness_trait = TRAIT_WEAK_LUNGS
	default_trigger_weight = FATNESS_LEVEL_MORBIDLY_OBESE	// It's called MORBIDLY obese for a reason
	override_quirk = TRAIT_HELPLESS_WEAK_LUNGS
	preference = /datum/preference/numeric/helplessness/weak_lungs
	gain_message = "You feel a tightness around your neck."
	lose_message = "You no longer feel a tightness around your neck."

/datum/helplessness/weak_lungs/apply_helplessness(mob/living/carbon/human/fatty, trigger_weight, fatness)
	. = ..()
	var/should_be_active = .

	if(!should_be_active)
		return should_be_active

	var/obj/item/organ/lungs/holder_lungs = fatty.get_organ_slot(ORGAN_SLOT_LUNGS)
	if (isnull(holder_lungs))
		return FALSE

	var/pressure_debuff = (fatness - trigger_weight) / (2 * trigger_weight)	// 1 when fatness = 3x trigger weight
	pressure_debuff = pressure_debuff * MAX_PRESSURE_DEBUFF		// scale it to be in range [0; MAX_PRESSURE_DEBUFF]
	pressure_debuff = max(1 - pressure_debuff, MAX_PRESSURE_DEBUFF)		// and in result, we reach this cap when fatness = 3x trigger weight
	holder_lungs.set_received_pressure_mult(pressure_debuff)

*/
#undef MAX_PRESSURE_DEBUFF
