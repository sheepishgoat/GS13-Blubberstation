/*
This was genuinely the most painful piece of code I ever had to write. Not because it's particularly
difficult or complicated or anything
but precisely because it is so simple
there is NOTHING fun about coding this
it's just pointless fucking "make 1 gaijilion copies of the same interaction for different use cases"
"oh and make sure they have neat flavor texts" FUCK YOU
*/
/datum/interaction/breast_feed_self
	name = "Breast feed"
	description = "Feed yourself using your breasts!"
	user_messages = list(
		"You lift your breasts to your mouth and begin sucking...",
		"You gently bite on your nipples and begin sucking..."
		)
	message = list("lifts their breasts into their mouth and begins sucking...")
	category = "Sex"
	usage = INTERACTION_SELF
	lewd = TRUE	// truth nuke
	user_required_parts = list(ORGAN_SLOT_BREASTS)
	user_pleasure = 1
	user_arousal = 2
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	color = "pink"
	// sexuality = 

/datum/interaction/breast_feed_self/act(mob/living/carbon/human/user, mob/living/carbon/human/target, obj/body_relay)
	. = ..()
	var/obj/item/organ/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if (!breasts.lactates)
		to_chat(user, span_warning("Your breasts do not produce milk!"))
		return

	if (!breasts.reagents.total_volume)
		to_chat(user, "There isn't any milk left in your breasts!")
		if(!user.has_status_effect(/datum/status_effect/body_fluid_regen/breasts)) // not producing milk? here, have some
			user.apply_status_effect(/datum/status_effect/body_fluid_regen/breasts)
		return

	breasts.reagents.trans_to(user, 5, transferred_by = user, methods = INGEST)
	to_chat(user, "You begin sucking on your own breasts, and can feel the taste of warm milk hit your tongue.")

/datum/interaction/breast_feed_other
	name = "Breast feed them"
	description = "Feed someone else using your breasts!"
	user_messages = list("You lift your breasts to %TARGET% mouth and start squeezing...")
	target_messages = list("%USER% brings their breasts to your mouth and starts squeezing...")
	message = list("lifts their breasts into %TARGET% mouth and begin squeezing...")
	category = "Sex"
	usage = INTERACTION_OTHER
	lewd = TRUE
	user_required_parts = list(ORGAN_SLOT_BREASTS)
	target_required_parts
	user_pleasure = 1	// values straight out of my ass
	user_arousal = 2
	target_pleasure = 2
	target_arousal = 2
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	color = "pink"
	// sexuality = 

/datum/interaction/breast_feed_other/act(mob/living/carbon/human/user, mob/living/carbon/human/target, obj/body_relay)
	. = ..()
	var/obj/item/organ/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)
	if (!breasts.lactates)
		to_chat(user, span_warning("Your breasts do not produce milk!"))
		return

	if (!breasts.reagents.total_volume)
		to_chat(user, "There isn't any milk left in your breasts!")
		if(!user.has_status_effect(/datum/status_effect/body_fluid_regen/breasts)) // not producing milk? here, have some
			user.apply_status_effect(/datum/status_effect/body_fluid_regen/breasts)
		return

	breasts.reagents.trans_to(target, 5, transferred_by = user, methods = INGEST)
	to_chat(user, "You begin sucking on your own breasts, and can feel the taste of warm milk hit your tongue.")
	

/datum/interaction/breast_feed_from_other
	name = "Breast feed from them"
	description = "Bite onto those milkers and begin sucking!"
	user_messages = list("You lift your breasts to your mouth and begin sucking...")
	target_messages = list("%USER% brings their breasts")
	message = list("lifts their breasts into their mouth and begin sucking...")
	category = "Sex"
	usage = INTERACTION_OTHER
	lewd = TRUE
	target_required_parts = list(ORGAN_SLOT_BREASTS)
	user_pleasure = 1
	user_arousal = 2
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	color = "pink"
	// sexuality = 
