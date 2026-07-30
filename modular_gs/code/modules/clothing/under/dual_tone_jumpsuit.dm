/obj/item/clothing/under/dual_tone
	name = "White dual tone jumpsuit (modular)"
	desc = "A dual tone colored jumpsuit. Check those stripes out baby!"

	modular_icon_location = 'modular_gs/icons/mob/modclothes/dual_tone_suit.dmi'
	greyscale_colors = "#FFFFFF#FFFFFF"			// I like this

	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/dual_tone"
	worn_icon = 'modular_gs/icons/mob/modclothes/dual_tone_suit_worn.dmi'
	post_init_icon_state = "dual_tone_jumpsuit"		// but why does it have to be this way

	armor_type = /datum/armor/clothing_under
	greyscale_config = /datum/greyscale_config/dual_tone_suit
	greyscale_config_worn = /datum/greyscale_config/dual_tone_suit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/dual_tone_suit/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/dual_tone_suit/worn/taur_snake

	flags_1 = IS_PLAYER_COLORABLE_1

/datum/greyscale_config/dual_tone_suit
	name = "Dual Tone Suit"
	icon_file = 'modular_gs/icons/obj/clothing/modclothes/dual_tone_suit.dmi'
	json_config = 'modular_gs/code/datums/greyscale/json_configs/dualtonesuit.json'

/datum/greyscale_config/dual_tone_suit/worn
	name = "Dual Tone Suit (Worn)"
	icon_file = 'modular_gs/icons/mob/modclothes/dual_tone_suit_worn.dmi'

/datum/greyscale_config/dual_tone_suit/worn/digi
	name = "Dual Tone Suit (Worn)(Digi)"
	icon_file = 'modular_gs/icons/mob/modclothes/dual_tone_suit_digi.dmi'

/datum/greyscale_config/dual_tone_suit/worn/taur_snake
	name = "Dual Tone Suit (Worn)(Taur)(Snake)"
	icon_file = 'modular_gs/icons/mob/modclothes/dual_tone_suit_taur_snake.dmi'

/obj/item/clothing/under/dual_tone/add_modular_overlay(mob/living/carbon/U, modular_icon, modular_layer, sprite_color, organ_slot)
	var/list/suit_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/mutable_appearance/mod_overlay = mutable_appearance(modular_icon_location, modular_icon, -(modular_layer))
	mod_overlays += mod_overlay
	U.overlays_standing[modular_layer] =  mod_overlay
	U.apply_overlay(modular_layer)
	for (var/i = 1, i < 3, i++)
		mod_overlay = mutable_appearance(modular_icon_location, (modular_icon + "-" + num2text(i)), -(modular_layer))
		mod_overlay.color = suit_colors[i]
		mod_overlays += mod_overlay
		U.overlays_standing[modular_layer] =  mod_overlay
		U.apply_overlay(modular_layer)

/obj/item/clothing/under/dual_tone/get_butt_alt()
	return ""

/obj/item/clothing/under/dual_tone/get_belly_size(obj/item/organ/genital/G)
	var/size = G.genital_size
	var/shape = "soft"
	var/stuffed_modifier = 0
	switch(G.owner.fullness)
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG) // Take the stuffed sprite of the same size
			stuffed_modifier = 0
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ) // Take the stuffed sprite of size + 1
			stuffed_modifier = 1
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)// Take the stuffed sprite of size + 2
			stuffed_modifier = 2
	size = size + stuffed_modifier

	size = min(size, 9)

	return "[shape]_[size]"
