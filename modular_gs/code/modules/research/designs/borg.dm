/obj/item/borg/upgrade/feeding_arm
	name = "food gripper module"
	desc = "An extra module that allows cyborgs to grab food and drinks, and feed them to people."
	icon_state = "module_general"
	items_to_add = list(/obj/item/borg/apparatus/food)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3
		)

/obj/item/borg/apparatus/food
	name = "food gripper"
	desc = "A simple grasping tool for interacting with various food and drink related items."
	item_flags = NOBLUDGEON

	storable = list(
		/obj/item/reagent_containers,
		/obj/item/food,
	)
