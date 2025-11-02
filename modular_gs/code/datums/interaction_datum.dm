/datum/interaction/breast_feed_self
	name = "Breast feed"
	description = "Feed yourself using your breasts"
	// user_messages = list("You lift your breasts to your mouth and begin sucking...")
	message = list("lifts their breasts into their mouth and begin sucking...")
	category = "Sex"
	usage = INTERACTION_SELF
	lewd = TRUE	// truth nuke
	user_required_parts = list(ORGAN_SLOT_BREASTS)
	user_pleasure = 1
	user_arousal = 2
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	color = ""
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
	to_chat(user, "As you begin sucking on your own breasts, the milk begins flowing...")
