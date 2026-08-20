// Ported from WG13, credit for the idea and the backbone of this weapon to M16nPregnant

#define CALORAY_DEFAULT_INTENSITY 50
#define MODE_FATTEN	"fatten"
#define MODE_THIN	"thin"

/obj/item/gun/medbeam/caloray
	name = "Caloray"
	desc = "A miniaturised and perfected combination of the adipoelectric generator and transformer, this device allows the user to convert energy into fat, and vice versa, at range."
	icon = 'modular_gs/icons/obj/weapons/caloray.dmi'
	icon_state = "caloray"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.8
		)

	var/mode = MODE_FATTEN
	var/beam_color = "#eb6e00"
	var/beam_icon_state = "white_beam_reverse"
	var/opened = FALSE
	var/intensity = CALORAY_DEFAULT_INTENSITY
	var/power_use = STANDARD_CELL_CHARGE * 5 / (10 * CALORAY_DEFAULT_INTENSITY)	// value in joules, with 20 intensity, it will result in 10% of the capacity of the default cell
	var/obj/item/stock_parts/power_store/cell/cell

/obj/item/gun/medbeam/caloray/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/gun/medbeam/caloray/empty_cell/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/high/empty
	update_appearance()

/obj/item/gun/medbeam/caloray/charged/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/high
	update_appearance()

/obj/item/gun/medbeam/caloray/infinite_cell
	name = "infinite capacity caloray"

/obj/item/gun/medbeam/caloray/infinite_cell/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/infinite
	update_appearance()

/obj/item/gun/medbeam/caloray/bluespace_cell
	name = "bluespace cell caloray"

/obj/item/gun/medbeam/caloray/bluespace_cell/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/power_store/cell/bluespace
	update_appearance()

/obj/item/gun/medbeam/caloray/examine(mob/user)
	. = ..()

	. += span_notice("It is currently set to [mode] at [intensity]% intensity.")

	if (cell)
		. += span_notice("It's cell is [cell.percent()]% charged.")
	else
		. += span_notice("It has no power cell installed.")

	if (opened)
		. += span_notice("It's battery compartment is currently open.")

/obj/item/gun/medbeam/caloray/update_overlays()
	. = ..()
	if(mode == MODE_FATTEN)
		. += "caloray_fatten"

	if(mode == MODE_THIN)
		. += "caloray_thin"


	if(!cell)
		. += "caloray_handle_off"
		. += "caloray_empty"
		return

	if(cell.percent() <= 20)
		. += "caloray_empty"
	else if(cell.percent() <= 80)
		. += "caloray_recharge"
	else
		. += "caloray_on"

	if(isnull(current_beam))
		. += "caloray_handle_off"
	else
		. += "caloray_handle_on"
		. += "caloray_activated"

/obj/item/gun/medbeam/caloray/attack_self(mob/user)
	if(opened == FALSE)
		playsound(user, 'sound/items/weapons/gun/general/slide_lock_1.ogg', 60, 1)
		if (mode == MODE_FATTEN)
			to_chat(user, span_notice("You change the setting on the beam to thin."))
			beam_color = "#3b0ce7"
			beam_icon_state = "white_beam"
			mode = MODE_THIN
		else
			to_chat(user, span_notice("You change the setting on the beam to fatten."))
			beam_color = "#eb6e00"
			beam_icon_state = "white_beam_reverse"
			mode = MODE_FATTEN

	if(opened == TRUE && cell)
		user.visible_message("[user] removes [cell] from [src]!", span_notice("You remove [cell]."))
		cell.update_icon()
		user.put_in_hands(cell)
		cell = null
		// playsound(user, 'sound/items/weapons/gun/general/ionpulse.ogg', 60, 1)

	else if(opened == TRUE && isnull(cell))
		user.visible_message(span_warning("The Caloray doesn't have a power cell installed."))

	update_appearance()
	LoseTarget()

/obj/item/gun/medbeam/caloray/attackby(obj/item/item, mob/user)
	if(item.tool_behaviour == TOOL_WRENCH)
		if(opened == FALSE)
			to_chat(user, span_notice("You open the Caloray's battery compartment."))
			opened = TRUE
		else
			to_chat(user, span_notice("You close the Caloray's battery compartment."))
			opened = FALSE

		item.play_tool_sound(src)
		LoseTarget()
		return

	if(opened && istype(item, /obj/item/stock_parts/power_store/cell))
		if(cell)
			to_chat(user, span_notice("[src] already has \a [cell] installed!"))
			return

		if(!user.transferItemToLoc(item, src))
			return

		to_chat(user, span_notice("You insert [item] into [src]."))
		cell = item

		if(mode == MODE_FATTEN)
			beam_color = "#eb6e00"
			beam_icon_state = "white_beam_reverse"
		if(mode == MODE_THIN)
			beam_color = "#3b0ce7"
			beam_icon_state = "white_beam"

		update_appearance()

/obj/item/gun/medbeam/caloray/LoseTarget()
	. = ..()
	update_appearance()

/obj/item/gun/medbeam/caloray/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(isliving(user))
		add_fingerprint(user)

	if(current_target)
		LoseTarget()

	if(!isliving(target))
		return

	if(isnull(cell))
		return

	if(cell.charge() == 0 && mode != MODE_THIN)
		return

	if(cell.charge() == cell.max_charge() && mode != MODE_FATTEN)
		return

	current_target = target
	active = TRUE
	current_beam = user.Beam(current_target, beam_icon_state, 'modular_gs/icons/effects/beam.dmi', beam_type = /obj/effect/ebeam/caloray, maxdistance = max_range, beam_color = beam_color)
	update_appearance()
	playsound(user, 'sound/items/weapons/gun/general/slide_lock_1.ogg', 60, 1)
	RegisterSignal(current_beam, COMSIG_QDELETING, PROC_REF(beam_died))//this is a WAY better rangecheck than what was done before (process check)
	START_PROCESSING(SSobj, src)

	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE

/obj/item/gun/medbeam/caloray/on_beam_tick(mob/living/carbon/target)
	if(mode == MODE_FATTEN)
		if(cell.charge() > 0)
			var/energy_used = cell.use(power_use * intensity, TRUE)
			target.adjust_fatness(energy_used / 250, FATTENING_TYPE_ITEM)	// assuming energy_used = power_use, this will result in a maximum of [intensity] BFI
		else
			LoseTarget()
			return

	if(mode == MODE_THIN)
		if(cell.charge() < cell.max_charge() && target.fatness_real > 0)
			var/BFI_burned = min(target.fatness_real, intensity)
			target.adjust_fatness(-BFI_burned, FATTENING_TYPE_ITEM)
			cell.give(BFI_burned * 250)	// with intensity 20, at most 5000 Joules
		else
			LoseTarget()
			return
	update_appearance()

/obj/effect/ebeam/caloray
	name = "caloray beam"

/obj/item/gun/medbeam/caloray/mid_los_check(atom/movable/user, mob/target, pass_args, turf/next_step, obj/dummy)
	return TRUE

//////////////////////////////Mech Version///////////////////////////////
/obj/item/gun/medbeam/caloray/mech
	mounted = TRUE

/obj/item/gun/medbeam/caloray/mech/Initialize(mapload)
	. = ..()
	STOP_PROCESSING(SSobj, src) //Mech mediguns do not process until installed, and are controlled by the holder obj

#undef CALORAY_DEFAULT_INTENSITY
#undef MODE_FATTEN
#undef MODE_THIN
