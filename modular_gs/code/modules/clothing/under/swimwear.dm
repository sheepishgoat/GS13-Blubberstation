/obj/item/clothing/under/dual_tone/swimwear
	name = "Sporty Swimwear (modular)"
	desc = "A dual tone colored swimming outfit, just barely modest enough."

	modular_icon_location = 'modular_gs/icons/mob/modclothes/swimwear.dmi'
	greyscale_colors = "#FFFFFF#FFFFFF"

	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/dual_tone/swimwear"
	worn_icon = 'modular_gs/icons/mob/modclothes/swimwear_worn.dmi'
	post_init_icon_state = "swimwear"

	armor_type = /datum/armor/clothing_under
	greyscale_config = /datum/greyscale_config/swimwear
	greyscale_config_worn = /datum/greyscale_config/swimwear/worn
	greyscale_config_worn_digi = /datum/greyscale_config/swimwear/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/swimwear/worn/taur_snake

	flags_1 = IS_PLAYER_COLORABLE_1

/datum/greyscale_config/swimwear
	name = "Dual Tone Sporty Swimwear"
	icon_file = 'modular_gs/icons/obj/clothing/modclothes/swimwear.dmi'
	json_config = 'modular_gs/code/datums/greyscale/json_configs/swimwear.json'

/datum/greyscale_config/swimwear/worn
	name = "Dual Sporty Swimwear (Worn)"
	icon_file = 'modular_gs/icons/mob/modclothes/swimwear_worn.dmi'

/datum/greyscale_config/swimwear/worn/digi
	name = "Dual Sporty Swimwear (Worn)(Digi)"
	icon_file = 'modular_gs/icons/mob/modclothes/swimwear_digi.dmi'

/datum/greyscale_config/swimwear/worn/taur_snake
	name = "Dual Sporty Swimwear (Worn)(Taur)(Snake)"
	icon_file = 'modular_gs/icons/mob/modclothes/swimwear_taur_snake.dmi'

/obj/item/clothing/under/dual_tone/swimwear/add_modular_overlays(mob/living/carbon/user, modular_icon, modular_layer, sprite_color, organ_slot)
	var/list/suit_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/modular_icon_state

	add_modular_overlay(user, modular_icon, modular_layer, "#FFFFFF")
	var/obj/item/organ/genital/organ = user.get_organ_slot(organ_slot)
	var/color = organ.bodypart_overlay.draw_color
	if (islist(color))
		color = color[1]

	modular_icon_state = (modular_icon + "-3")
	add_modular_overlay(user, modular_icon_state, modular_layer, color)

	for (var/i = 1, i < 3, i++) // layering hell because god hates spriters.
		modular_icon_state = modular_icon + "-" + num2text(i)
		add_modular_overlay(user, modular_icon_state, modular_layer, suit_colors[i])
