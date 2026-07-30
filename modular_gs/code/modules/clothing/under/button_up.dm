/obj/item/clothing/under/dual_tone/button_up
	name = "Button up shirt (modular)"
	desc = "A buttoned up shirt. Made by GATO to be particularly stretchy."

	modular_icon_location = 'modular_gs/icons/mob/modclothes/button_up.dmi'
	greyscale_colors = "#FFFFFF#FFFFFF#FFFFFF"

	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/dual_tone/button_up"
	worn_icon = 'modular_gs/icons/mob/modclothes/button_up_worn.dmi'
	post_init_icon_state = "button_up"		// but why does it have to be this way

	armor_type = /datum/armor/clothing_under
	greyscale_config = /datum/greyscale_config/button_up
	greyscale_config_worn = /datum/greyscale_config/button_up/worn
	greyscale_config_worn_digi = /datum/greyscale_config/button_up/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/button_up/worn/taur_snake

/datum/greyscale_config/button_up
	name = "Button Up Suit"
	icon_file = 'modular_gs/icons/obj/clothing/modclothes/button_up.dmi'
	json_config = 'modular_gs/code/datums/greyscale/json_configs/button_up.json'

/datum/greyscale_config/button_up/worn
	name = "Button Up Suit (Worn)"
	icon_file = 'modular_gs/icons/mob/modclothes/button_up_worn.dmi'

/datum/greyscale_config/button_up/worn/digi
	name = "Button Up Suit (Worn)(Digi)"
	icon_file = 'modular_gs/icons/mob/modclothes/button_up_digi.dmi'

/datum/greyscale_config/button_up/worn/taur_snake
	name = "Button Up Suit (Worn)(Taur)(Snake)"
	icon_file = 'modular_gs/icons/mob/modclothes/button_up_taur_snake.dmi'

/obj/item/clothing/under/dual_tone/button_up/add_modular_overlay(mob/living/carbon/user, modular_icon, modular_layer, sprite_color, organ_slot)
	var/list/suit_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/mutable_appearance/mod_overlay = mutable_appearance(modular_icon_location, modular_icon, -(modular_layer))
	mod_overlays += mod_overlay
	user.overlays_standing[modular_layer] =  mod_overlay
	user.apply_overlay(modular_layer)
	for (var/i = 1, i < 4, i++)
		mod_overlay = mutable_appearance(modular_icon_location, (modular_icon + "-" + num2text(i)), -(modular_layer))
		mod_overlay.color = suit_colors[i]
		mod_overlays += mod_overlay
		user.overlays_standing[modular_layer] =  mod_overlay
		user.apply_overlay(modular_layer)

	var/obj/item/organ/genital/organ = user.get_organ_slot(organ_slot)
	var/color = organ.bodypart_overlay.draw_color
	if (islist(color))
		color = color[1]

	mod_overlay = mutable_appearance(modular_icon_location, (modular_icon + "-4"), -(modular_layer))
	mod_overlay.color = color
	mod_overlays += mod_overlay
	user.overlays_standing[modular_layer] =  mod_overlay
	user.apply_overlay(modular_layer)
