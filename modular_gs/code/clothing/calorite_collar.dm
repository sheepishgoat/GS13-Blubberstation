#define WEIGHT_GAIN_MODIFIER_COLLAR "calorite_collar"

/obj/item/clothing/neck
	///How much faster does the wearer gain weight? 1 = 100% faster
	var/weight_gain_rate_modifier = 0

/obj/item/clothing/neck/equipped(mob/user, slot)
	. = ..()

	var/mob/living/carbon/wearer = user
	if(!weight_gain_rate_modifier)
		return FALSE

	if(!iscarbon(wearer) || slot !=ITEM_SLOT_NECK || !wearer?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_items))
		return FALSE

	wearer.add_weight_gain_modifier(WEIGHT_GAIN_MODIFIER_COLLAR, weight_gain_rate_modifier)

/obj/item/clothing/neck/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/wearer = user
	if(!weight_gain_rate_modifier)
		return FALSE

	if(!iscarbon(wearer) || !(wearer.get_item_by_slot(ITEM_SLOT_NECK) == src) || !wearer?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_items))
		return FALSE

	wearer.remove_weight_gain_modifier(WEIGHT_GAIN_MODIFIER_COLLAR)


/obj/item/clothing/neck/human_petcollar/calorite
	name = "calorite collar"
	desc = "A modified pet collar infused with calorite, magnifying the caloric impact of any food the wearer eats"
	weight_gain_rate_modifier = 0.5
	greyscale_colors = "#303030"			// I like this
	icon_state = "/obj/item/clothing/neck/human_petcollar/calorite"
	worn_icon = 'modular_gs/icons/mob/clothing/cal_collar.dmi'
	post_init_icon_state = "calorite_collar"
	greyscale_config = /datum/greyscale_config/calorite_collar
	greyscale_config_worn = /datum/greyscale_config/calorite_collar/worn


/obj/item/clothing/neck/human_petcollar/locked/calorite
	name = "locked calorite collar"
	desc = "A modified locked collar infused with calorite, magnifying the caloric impact of any food the wearer eats"
	weight_gain_rate_modifier = 0.5
	greyscale_colors = "#303030"			// I like this
	icon_state = "/obj/item/clothing/neck/human_petcollar/calorite"
	worn_icon = 'modular_gs/icons/mob/clothing/cal_collar.dmi'
	post_init_icon_state = "calorite_collar"
	greyscale_config = /datum/greyscale_config/calorite_collar
	greyscale_config_worn = /datum/greyscale_config/calorite_collar/worn

/datum/greyscale_config/calorite_collar
	name = "Calorite Collar"
	icon_file = 'modular_gs/icons/obj/clothing/cal_collar.dmi'
	json_config = 'modular_gs/code/datums/greyscale/json_configs/calorite_collar.json'

/datum/greyscale_config/calorite_collar/worn
	name = "Calorite Collar (Worn)"
	icon_file = 'modular_gs/icons/mob/clothing/cal_collar.dmi'
	json_config = 'modular_gs/code/datums/greyscale/json_configs/calorite_collar_wear.json'

/datum/crafting_recipe/calorite_collar
	name = "Calorite Collar"
	tool_behaviors = list(TOOL_WRENCH, TOOL_WELDER)
	result = /obj/item/clothing/neck/human_petcollar/calorite
	reqs = list(/obj/item/clothing/neck/human_petcollar = 1,
				/obj/item/stack/sheet/mineral/calorite = 3)
	time = 25 SECONDS
	category = CAT_CLOTHING
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/locked_calorite_collar

	name = "Locked Calorite Collar"
	tool_behaviors = list(TOOL_WRENCH, TOOL_WELDER)
	result = /obj/item/clothing/neck/human_petcollar/locked/calorite
	reqs = list(/obj/item/clothing/neck/human_petcollar/locked = 1,
				/obj/item/stack/sheet/mineral/calorite = 3)
	time = 25 SECONDS
	category = CAT_CLOTHING
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY

#undef WEIGHT_GAIN_MODIFIER_COLLAR
