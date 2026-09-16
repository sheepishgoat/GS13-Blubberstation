/obj/item/clothing/under/dual_tone/bunny_suit
	name = "Bunny suit (modular)"
	desc = "A particularly stretchy bunny suit."

	modular_icon_location = 'modular_gs/icons/mob/modclothes/bunny_suit.dmi'
	greyscale_colors = "#FFFFFF#FFFFFF#FFFFFF#FFFFFF#FFFFFF#FFFFFF"

	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/dual_tone/bunny_suit"
	worn_icon = 'modular_gs/icons/mob/modclothes/dual_tone_suit_worn.dmi'
	post_init_icon_state = "bunny_suit"		// but why does it have to be this way

	greyscale_config = /datum/greyscale_config/bunny_suit
	greyscale_config_worn = /datum/greyscale_config/bunny_suit/worn
	greyscale_config_worn_digi = /datum/greyscale_config/bunny_suit/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/bunny_suit/worn/taur_snake

/datum/greyscale_config/bunny_suit
	name = "Bunny Suit"
	icon_file = 'modular_gs/icons/obj/clothing/modclothes/bunny_suit.dmi'
	json_config = 'modular_gs/code/datums/greyscale/json_configs/bunny_suit.json'

/datum/greyscale_config/bunny_suit/worn
	name = "Bunny Suit (Worn)"
	icon_file = 'modular_gs/icons/mob/modclothes/bunny_suit_worn.dmi'

/datum/greyscale_config/bunny_suit/worn/digi
	name = "Bunny Suit (Worn)(Digi)"
	icon_file = 'modular_gs/icons/mob/modclothes/bunny_suit_digi.dmi'

/datum/greyscale_config/bunny_suit/worn/taur_snake
	name = "Bunny Suit (Worn)(Taur)(Snake)"
	icon_file = 'modular_gs/icons/mob/modclothes/bunny_suit_taur_snake.dmi'

/obj/item/clothing/under/dual_tone/bunny_suit/add_modular_overlays(mob/living/carbon/user, modular_icon, modular_layer, sprite_color, organ_slot)
	var/list/suit_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/modular_icon_state

	add_modular_overlay(user, modular_icon, modular_layer, "#FFFFFF")
	var/obj/item/organ/genital/organ = user.get_organ_slot(organ_slot)
	var/color = organ.bodypart_overlay.draw_color
	if (islist(color))
		color = color[1]

	modular_icon_state = (modular_icon + "-1")
	add_modular_overlay(user, modular_icon_state, modular_layer, color)

	for (var/i = 2, i < 8, i++)
		modular_icon_state = modular_icon + "-" + num2text(i)
		add_modular_overlay(user, modular_icon_state, modular_layer, suit_colors[i-1])
