/obj/item/organ/tongue/porcine
	name = "porcine tongue"
	desc = "A thick, flat tongue. It seems to twitch whenever there's food nearby."
	say_mod = "oinks"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/porcine/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "snuffles"
	signer.verb_exclaim = "snorts"
	signer.verb_whisper = "grunts"
	signer.verb_yell = "squeals"

/obj/item/organ/tongue/porcine/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/datum/quirk/item_quirk/porcine
	name = "Porcine Traits"
	desc = "Oink. You seem to act like a pig for whatever reason. This will replace most other tongue-based speech quirks."
	mob_trait = TRAIT_PORCINE
	icon = FA_ICON_PIGGY_BANK
	value = 0
	medical_record_text = "Patient exhibits porcine-adjacent mannerisms."

/datum/quirk/item_quirk/porcine/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/porcine/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)
