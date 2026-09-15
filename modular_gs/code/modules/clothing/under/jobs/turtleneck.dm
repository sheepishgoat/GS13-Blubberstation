/obj/item/clothing/under/dual_tone/button_up/turtleneck
	name = "turtleneck shirt (modular)"
	desc = "A turtleneck shirt. Its a bit tight..."

	modular_icon_location = 'modular_gs/icons/mob/modclothes/turtleneck.dmi'
	greyscale_colors = "#FFFFFF#FFFFFF#FFFFFF"

	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	icon_state = "/obj/item/clothing/under/dual_tone/turtleneck"
	worn_icon = 'modular_gs/icons/mob/modclothes/turtleneck_worn.dmi'
	post_init_icon_state = "turtleneck"

	armor_type = /datum/armor/clothing_under
	greyscale_config = /datum/greyscale_config/turtleneck
	greyscale_config_worn = /datum/greyscale_config/turtleneck/worn
	greyscale_config_worn_digi = /datum/greyscale_config/turtleneck/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/turtleneck/worn/taur_snake

/datum/greyscale_config/turtleneck
	name = "Turtleneck Shirt"
	icon_file = 'modular_gs/icons/obj/clothing/modclothes/turtleneck.dmi'
	json_config = 'modular_gs/code/datums/greyscale/json_configs/turtleneck.json'

/datum/greyscale_config/turtleneck/worn
	name = "Turtleneck Shirt (Worn)"
	icon_file = 'modular_gs/icons/mob/modclothes/turtleneck_worn.dmi'

/datum/greyscale_config/turtleneck/worn/digi
	name = "Turtleneck Shirt (Worn)(Digi)"
	icon_file = 'modular_gs/icons/mob/modclothes/turtleneck_digi.dmi'

/datum/greyscale_config/turtleneck/worn/taur_snake
	name = "Turtleneck Shirt (Worn)(Taur)(Snake)"
	icon_file = 'modular_gs/icons/mob/modclothes/turtleneck_taur_snake.dmi'
