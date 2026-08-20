/obj/item/clothing/neck/kink_collar/locked/antiburst
	name = "WT field generator collar" // coder item name, if you think of something better, PR it in.
	desc = "A collar that prevents accidental bursting by generating a water-tight field."
	icon_state = "/obj/item/clothing/neck/kink_collar/locked/antiburst"
	post_init_icon_state = "gps"
	greyscale_config = /datum/greyscale_config/collar/gps
	greyscale_config_worn = /datum/greyscale_config/collar/gps/worn
	greyscale_config_inhand_left = /datum/greyscale_config/collar/gps/lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/collar/gps/righthand
	greyscale_colors = "#0B2A8F#0A0F1D"
	resistance_flags = FIRE_PROOF | UNACIDABLE // It's made for containing walking biohazards, of course it's 100% acid proof.
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5, /datum/material/calorite = SHEET_MATERIAL_AMOUNT *0.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.25)
	/// The default signaller code of the toy
	var/code = 2
	/// The default frequency of the toy
	var/frequency = FREQ_ELECTROPACK
	/// is the field currently active?
	var/field_active = FALSE

/obj/item/clothing/neck/kink_collar/locked/antiburst/Initialize(mapload)
	. = ..()
	set_frequency(frequency)
	update_icon(UPDATE_OVERLAYS)
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/neck/kink_collar/locked/antiburst/attack_self(mob/user)
	return ui_interact(user)

/obj/item/clothing/neck/kink_collar/locked/antiburst/examine(mob/user)
	. = ..()
	. += span_notice("Use in hand to open the menu.")

/obj/item/clothing/neck/kink_collar/locked/antiburst/equipped(mob/user, slot)
	. = ..()
	if(!iscarbon(user))
		return
	if(field_active && (slot & ITEM_SLOT_NECK))
		activate_field()

/obj/item/clothing/neck/kink_collar/locked/antiburst/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return

	var/mob/living/carbon/wearer = user
	var/is_worn = (wearer?.get_item_by_slot(ITEM_SLOT_NECK) == src)
	var/is_qdeleted = QDELETED(src)
	if(is_worn && !is_qdeleted && field_active)
		disable_field()

/// Toggles the anti-bursting field on and off
/obj/item/clothing/neck/kink_collar/locked/antiburst/proc/toggle_field()
	field_active = !field_active
	update_icon_state()
	update_icon()

	if(!field_active)
		disable_field()
		return TRUE

	activate_field()
	return TRUE

/// Call this whenever putting the collar on someone with the field enabled or upon re-enabling the field.
/obj/item/clothing/neck/kink_collar/locked/antiburst/proc/activate_field()
	var/mob/living/carbon/human/attached_user = loc
	if(!istype(attached_user) || (attached_user.get_item_by_slot(ITEM_SLOT_NECK) != src))
		visible_message(span_notice("The [src] will now emit a stabilizing field.")) // Show this when the object isn't currently worn.
		return

	to_chat(attached_user, span_notice("The stabilizing field on the [src] engages, preventing you from popping."))
	ADD_TRAIT(attached_user, TRAIT_NO_BURST, ref(src))

/// Call this whenever removing the collar or disabling the field
/obj/item/clothing/neck/kink_collar/locked/antiburst/proc/disable_field()
	var/mob/living/carbon/human/attached_user = loc
	if(!istype(attached_user) || (attached_user.get_item_by_slot(ITEM_SLOT_NECK) != src))
		visible_message(span_notice("The [src] will no longer emit a stabilizing field."))
		return

	to_chat(attached_user, span_warning("The stabilizing field on the [src] disengages, no logner preventing you from popping."))
	REMOVE_TRAIT(attached_user, TRAIT_NO_BURST, ref(src))


/obj/item/clothing/neck/kink_collar/locked/antiburst/update_overlays()
	. = ..()
	if(field_active)
		. += mutable_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "light")
		. += emissive_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "light", src, alpha = src.alpha)

/obj/item/clothing/neck/kink_collar/locked/antiburst/worn_overlays(mutable_appearance/standing, isinhands = FALSE)
	. = ..()
	if(field_active && !isinhands)
		. += mutable_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "collar_mob_tracker_light")
		. += emissive_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "collar_mob_tracker_light", src, alpha = src.alpha)

/obj/item/clothing/neck/kink_collar/locked/antiburst/ui_state(mob/user)
	return GLOB.hands_state

// Yes we are using mostly copy and pasted vibrator code.
/obj/item/clothing/neck/kink_collar/locked/antiburst/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Signalvib", name)
		ui.open()

/obj/item/clothing/neck/kink_collar/locked/antiburst/ui_data(mob/user)
	var/list/data = list()
	data["toystate"] = field_active
	data["frequency"] = frequency
	data["code"] = code
	data["minFrequency"] = MIN_FREE_FREQ
	data["maxFrequency"] = MAX_FREE_FREQ
	return data

/obj/item/clothing/neck/kink_collar/locked/antiburst/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toystate")
			toggle_field()
			. = TRUE

		if("freq")
			var/value = unformat_frequency(params["freq"])
			if(value)
				frequency = sanitize_frequency(value, TRUE)
				set_frequency(frequency)
				. = TRUE

		if("code")
			var/value = text2num(params["code"])
			if(value)
				value = round(value)
				code = clamp(value, 1, 100)
				. = TRUE

		if("reset")
			if(params["reset"] == "freq")
				frequency = initial(frequency)
				. = TRUE

			else if(params["reset"] == "code")
				code = initial(code)
				. = TRUE

/obj/item/clothing/neck/kink_collar/locked/antiburst/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/clothing/neck/kink_collar/locked/antiburst/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/clothing/neck/kink_collar/locked/antiburst/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return

	toggle_field()
