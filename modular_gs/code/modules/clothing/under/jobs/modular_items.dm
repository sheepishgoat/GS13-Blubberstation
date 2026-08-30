//////////////////////////////////////
//			MODULAR ITEMS 2.0 		//
//	BETTER AND BIGGER THAN EVER		//
//////////////////////////////////////

//HOW TO CREATE A NEW MODULAR ITEM
// 1) DRAW THE SPRITES (see already made modular sprites)
// 2) FIND THE ITEM YOU WANT TO MAKE MODULAR (example: the grey jumpsuit is /obj/item/clothing/under/color/grey )
// 3) CHANGE IT'S modular_icon_location TO BE THE LOCATION OF THE SPRITES YOU'VE MADE (example: modular_icon_location = 'modular_gs/icons/mob/modclothes/modular_grey.dmi')
// 4) YOU ARE DONE. YOUR ITEM IS NOW MODULAR

//Many functions of the system can be customized by overloading the various procs
//If you know what you are doing then I encoourage you to tweak your item to work better for the idea you had in mind

// Called by handle_fatness, this is called periodically to tell all items to check for sprites and, if needed, build new ones
/mob/living/carbon/proc/handle_modular_items()
	for(var/obj/item/item in modular_items)
		item.update_modular_overlays(src)

/obj/item
	var/modular_icon_location = null	//Locates the sprites, null if it is not a modular item. Changing this makes the item modular
	var/mod_overlays = list()			//Keeps track of the modular sprite overlays for the item
	var/mod_breasts_rec					//Records the last used sprite for breasts to avoid building sprites if no change occurred
	var/mod_butt_rec					//^^^ for butt
	var/mod_belly_rec					//^^^ for belly

//General condition for activating modular sprites for an item.
//When equipped to that item's appropriate slot, if the item has modular icons then initialize it as a modular item
/obj/item/equipped(mob/user, slot)
	if(modular_icon_location != null && slot == slot_flags)
		add_modular_item(user)
		RegisterSignal(user, COMSIG_HUMAN_TOGGLE_GENITALS, PROC_REF(refresh_modular_item), user)
	..()

/// deletes all modular overlays and forces them to be reapplied
/obj/item/proc/refresh_modular_item(mob/user)
	delete_modular_overlays(user)
	add_modular_item(user)

//General condition for deactivating modular sprites for an item.
//When dropped. And/or moved to another slot, works together with equipped checking the approporiate slot
/obj/item/dropped(mob/user)
	..()
	UnregisterSignal(user, COMSIG_HUMAN_TOGGLE_GENITALS)
	remove_modular_item(user)

//Initialize a modular item by resetting any recorded sprite names and force a sprite update
/obj/item/proc/add_modular_item(mob/user)
	mod_breasts_rec = null
	mod_butt_rec = null
	mod_belly_rec = null
	update_modular_overlays(user)

//Remove a modular item by deleting it from the user's list of tracked modular items
//and forcing sprite deletion
/obj/item/proc/remove_modular_item(mob/user)
	if(!iscarbon(user))
		return
	delete_modular_overlays(user)
	var/mob/living/carbon/carbon = user
	if(src in carbon.modular_items)
		carbon.modular_items -= src

//The meat of the system, checks the genitals, compares to recorded size and request
//the sprites if new ones are needed
/obj/item/proc/update_modular_overlays(mob/user_mob)
	if(modular_icon_location == null)
		return
	if(!iscarbon(user_mob))
		return
	var/mob/living/carbon/user = user_mob

	/// holder for the genitals which we have and need updating
	var/list/genitals_list
	/// do we even have to update our sprites?
	var/build_modular = FALSE

	// Before requesting sprites we must make sure new ones are actually needed
	// Find the belly, butt and breasts of the user (individually, not all 3 are needed)
	// Add it to a list of found genitals
	// Get the sprite name of the sprites needed and compare it to the ones recorded
	// If they are different, record the sprites and build_modular to TRUE to signal that new sprites are needed
	
	var/obj/item/organ/genital/belly/belly = user_mob.get_organ_slot(ORGAN_SLOT_BELLY)
	if (!isnull(belly))
		genitals_list += list(belly)
		var/modular_belly = get_modular_belly(belly)
		if (modular_belly != mod_belly_rec)
			mod_belly_rec = modular_belly
			build_modular = TRUE
	
	var/obj/item/organ/genital/butt/butt = user_mob.get_organ_slot(ORGAN_SLOT_BUTT)
	if (!isnull(butt))
		genitals_list += list(butt)
		var/modular_butt = get_modular_butt(butt)
		if (modular_butt != mod_butt_rec)
			mod_butt_rec = modular_butt
			build_modular = TRUE

	var/obj/item/organ/genital/breasts/breasts = user_mob.get_organ_slot(ORGAN_SLOT_BREASTS)
	if (!isnull(breasts))
		genitals_list += list(breasts)
		var/modular_tits = get_modular_breasts(breasts)
		if (modular_tits != mod_breasts_rec)
			mod_breasts_rec = modular_tits
			build_modular = TRUE

	if(!build_modular)	//Stop early if no new sprites are needed
		return
	delete_modular_overlays(user)	//Delete the old sprites

	if(!(src in user.modular_items))	//Make sure the item is inside the user's tracked modular items
		user.modular_items += src		//used on the first sprite request and to ensure it's being tracked for future updates

	//Go through the list of genitals previously found and for each add the modular sprite overlays to the user
	var/obj/item/organ/genital/genital
	for(genital in genitals_list)
		if (genital.visibility_preference == GENITAL_ALWAYS_SHOW)
			continue
		if(istype(genital, /obj/item/organ/genital/belly))
			add_modular_overlay(user, mod_belly_rec, MODULAR_BELLY_LAYER, greyscale_colors, ORGAN_SLOT_BELLY)
			add_modular_overlay(user, "[mod_belly_rec]_SOUTH", BELLY_FRONT_LAYER, greyscale_colors, ORGAN_SLOT_BELLY)
			continue
		if(istype(genital, /obj/item/organ/genital/butt))
			add_modular_overlay(user, mod_butt_rec, MODULAR_BUTT_LAYER, greyscale_colors, ORGAN_SLOT_BUTT)
			add_modular_overlay(user, "[mod_butt_rec]_NORTH", BUTT_BEHIND_LAYER, greyscale_colors, ORGAN_SLOT_BUTT)
			continue
		if(istype(genital, /obj/item/organ/genital/breasts))
			add_modular_overlay(user, mod_breasts_rec, MODULAR_BREASTS_LAYER, greyscale_colors, ORGAN_SLOT_BREASTS)
			add_modular_overlay(user, "[mod_breasts_rec]_NORTH", BREASTS_BEHIND_LAYER, greyscale_colors, ORGAN_SLOT_BREASTS)
			add_modular_overlay(user, "[mod_breasts_rec]_SOUTH", BREASTS_FRONT_LAYER, greyscale_colors, ORGAN_SLOT_BREASTS)

//Remove the previously built modular sprite overlays and empty the list of tracked overlays
/obj/item/proc/delete_modular_overlays(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/carbon_user = user
	if(!(src in carbon_user.modular_items))
		return
	for(var/mutable_appearance/overlay in mod_overlays)
		carbon_user.cut_overlay(overlay)
	mod_overlays -= mod_overlays

//Function to easily add a requested overlay
//Create the appropriate sprite object (mod_overlay) using the icon previously found, from the item's modular sprites file, on the appropriate overlay and with the item's color
//The sprite is then added to the item's list of built modular sprites overlay
//Added to the appropriate layer of the user
//Then the layer is applied
//
// Why is the layer in mutable appearance entered as its negative version?
// No. Damn. Clue. SS13, I don't question it further.
//
/obj/item/proc/add_modular_overlay(mob/living/carbon/user, modular_icon, modular_layer, sprite_color, organ_slot)
	var/mutable_appearance/mod_overlay = mutable_appearance(modular_icon_location, modular_icon, -(modular_layer))
	mod_overlay.color = sprite_color
	mod_overlays += mod_overlay
	user.overlays_standing[modular_layer] =  mod_overlay
	user.apply_overlay(modular_layer)

//General function to generate the right icon_state for belly modular sprites
/obj/item/proc/get_modular_belly(obj/item/organ/genital/genital)
	return "belly_[get_belly_size(genital)][get_belly_alt()]"

//General function to get the appropriate shape and size for the belly, accounting for fullness
/obj/item/proc/get_belly_size(obj/item/organ/genital/belly)
	var/size = belly.genital_size
	var/shape = "soft"
	if(belly.owner.fullness <= FULLNESS_LEVEL_BLOATED)
		switch(belly.genital_type)
			if("belly")
				shape = "soft"
			if("round")
				shape = "round"
	else
		shape = "stuffed"
		var/stuffed_modifier = 0
		switch(belly.owner.fullness)
			if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG) // Take the stuffed sprite of the same size
				stuffed_modifier = 0
			if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ) // Take the stuffed sprite of size + 1
				stuffed_modifier = 1
			if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)// Take the stuffed sprite of size + 2
				stuffed_modifier = 2
		size = size + stuffed_modifier
		
	size = min(size, 9)

	return "[shape]_[size]"

//Placeholder function for alternate variants of the shape and size sprites for belly
/obj/item/proc/get_belly_alt()
	return ""

//General function to get the appropriate shape and size for the butt
/obj/item/proc/get_modular_butt(obj/item/organ/genital/butt)
	return "butt_[(butt.genital_size <= 10 ) ? "[butt.genital_size]" : "10"][get_butt_alt()]"

//General function to get the alternate variants for butt sprites, used for digitigrade characters
/obj/item/proc/get_butt_alt()
	return "[(supports_variations_flags == CLOTHING_DIGITIGRADE_VARIATION) ? "_l" : ""]"

//General function to get the appropriate size for the breasts
/obj/item/proc/get_modular_breasts(obj/item/organ/genital/tits)
	var/size
	if(tits.genital_size <= 15)
		size = tits.genital_size
	else
		switch(tits.genital_size)
			if(16)
				size = "huge"
			if(17)
				size = "massive"
			if(18)
				size = "giga"
			if(19)
				size = "impossible"
	return "breasts_[size][get_breasts_alt()]"

//Placeholder function for alternate variants of the breasts
/obj/item/proc/get_breasts_alt()
	return ""

//The modular grey jumpsuit. The foundation of modular items and our holy grail
/obj/item/clothing/under/color/grey
	name = "grey jumpsuit (Modular)"												//(Modular) to tell players it is modular
	modular_icon_location = 'modular_gs/icons/mob/modclothes/modular_grey.dmi'	//Location of the sprites, to make it modular
	desc = "A tasteful grey jumpsuit that reminds you of the good old days."
	armor_type = /datum/armor/clothing_under

//Overload of the alt belly sprites function, for adjusteable clothing
/obj/item/clothing/under/get_belly_alt()
	return "[(adjusted) ? "_d" : ""]"

//The placeholder colored jumpsuits
/obj/item/clothing/under/color/grey/service
	name = "service grey jumpsuit (Modular)"
	desc = "Grey only in name"
	icon_state = "/obj/item/clothing/under/color/grey/service"
	greyscale_colors = "#6AD427"
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/grey/medical
	name = "medical grey jumpsuit (Modular)"
	desc = "Grey only in name"
	icon_state = "/obj/item/clothing/under/color/grey/medical"
	greyscale_colors = "#5A96BB"
	armor_type = /datum/armor/clothing_under/rank_medical
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/grey/cargo
	name = "cargo grey jumpsuit (Modular)"
	desc = "Grey only in name"
	icon_state = "/obj/item/clothing/under/color/grey/cargo"
	greyscale_colors = "#BB9042"
	armor_type = /datum/armor/clothing_under/cargo_miner
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/grey/engi
	name = "engineering grey jumpsuit (Modular)"
	desc = "Grey only in name"
	icon_state = "/obj/item/clothing/under/color/grey/engi"
	greyscale_colors = "#FF8800"
	armor_type = /datum/armor/clothing_under/rank_engineering
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/grey/science
	name = "science grey jumpsuit (Modular)"
	desc = "Grey only in name"
	icon_state = "/obj/item/clothing/under/color/grey/science"
	greyscale_colors = "#9900FF"
	armor_type = /datum/armor/clothing_under/science
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/grey/security
	name = "security grey jumpsuit (Modular)"
	desc = "Grey only in name"
	icon_state = "/obj/item/clothing/under/color/grey/security"
	greyscale_colors = "#F4080C"
	armor_type = /datum/armor/clothing_under/rank_security
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/grey/security/blue
	name = "blue security grey jumpsuit (Modular)"
	desc = "\"blue security grey\". You came up with that yourself?"
	icon_state = "/obj/item/clothing/under/color/grey/security/blue"
	greyscale_colors = "#00386e"

/obj/item/clothing/under/color/grey/command
	name = "command grey jumpsuit (Modular)"
	desc = "Grey only in name"
	icon_state = "/obj/item/clothing/under/color/grey/command"
	greyscale_colors = "#004B8F"
	armor_type = /datum/armor/clothing_under/rank_captain
	flags_1 = 0		// make it non-recolorable
