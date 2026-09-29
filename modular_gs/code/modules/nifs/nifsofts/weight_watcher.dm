/datum/nifsoft/fat_scanner
	name = "Weight Watcher"
	program_desc = "Allows the user to accurately judge the weight of those they look at."
	active_mode = TRUE
	active_cost = 0.01
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = "magnifying-glass"
	purchase_price = 100
	able_to_keep = TRUE

/datum/nifsoft/fat_scanner/activate()
	. = ..()
	if(!active || !.)
		REMOVE_TRAIT(linked_mob, TRAIT_FAT_SCANNER, REF(src))
		return

	ADD_TRAIT(linked_mob, TRAIT_FAT_SCANNER, REF(src))
