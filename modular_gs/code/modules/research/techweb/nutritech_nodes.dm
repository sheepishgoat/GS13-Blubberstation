/////////////// GS13 - NUTRITIONAL TECHNOLOGY

#define TECHWEB_NODE_NUTRIWEAPONS "nutritech_weapons"
#define TECHWEB_NODE_NUTRITOOLS "nutritech_tools"

/datum/techweb_node/nutritech_tools
	id = TECHWEB_NODE_NUTRITOOLS
	display_name = "Nutri-Tech Tools"
	description = "Ending world hunger was never made easier!"
	prereq_ids = list(TECHWEB_NODE_MEDBAY_EQUIP, TECHWEB_NODE_EXP_TOOLS)
	design_ids = list(
		"calorite_collar",
		"ci-nutrimentturbo",
		"bluespace_belt",
		"adipoelectric_transformer",
		"adipoelectric_generator",
		"cookie_synthesizer",
		"borg_upgrade_cookiesynthesizer",
		"borg_feeding_tube_upgrade",
		"ci-fatmobility",
		"bluespace_collar_receiver",
		"bluespace_collar_transmitter",
		"blueberry_field_collar",
		)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_items_to_unlock = list(
		/obj/item/gun/energy/fatoray,
		/obj/item/gun/energy/fatoray/cannon,
		/obj/item/trash/fatoray_scrap1,
		/obj/item/trash/fatoray_scrap2
		)
	hidden = TRUE

/datum/techweb_node/nutritech_weapons
	id = TECHWEB_NODE_NUTRIWEAPONS
	display_name = "Nutri-Tech Weapons"
	description = "Ever wanted to reach your daily caloric intake in just 5 seconds?"
	prereq_ids = list(TECHWEB_NODE_MEDBAY_EQUIP, TECHWEB_NODE_EXP_TOOLS)
	design_ids = list(
		"fatoray_weak",
		"fatoray_cannon_weak",
		"alter_ray_metabolism",
		"alter_ray_reverser",
		"borg_upgrade_fatoray",
		"bwomf_nanites",
		"caloray",
		// "docility_implant"
		)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_items_to_unlock = list(
		/obj/item/gun/energy/fatoray,
		/obj/item/gun/energy/fatoray/cannon,
		/obj/item/trash/fatoray_scrap1,
		/obj/item/trash/fatoray_scrap2
		)
	hidden = TRUE

#undef TECHWEB_NODE_NUTRIWEAPONS
#undef TECHWEB_NODE_NUTRITOOLS
