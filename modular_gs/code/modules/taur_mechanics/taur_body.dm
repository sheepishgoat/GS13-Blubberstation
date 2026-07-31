/obj/item/organ/taur_body/proc/set_size_from_weight(size_change)
	if (mutantpart_info[MUTANT_INDEX_NAME] != "Drake")
		stack_trace("set_size_from_weight on a taur body called on a taur that's not a drake.")
		return

	var/datum/bodypart_overlay/mutant/taur_body/our_sprite_overlay = bodypart_overlay
	if (!istype(our_sprite_overlay))
		stack_trace("set_size_from_weight on a taur body called bodypart_overlay that's not a taur body.")
		return

	our_sprite_overlay.taur_belly_size = size_change

/datum/sprite_accessory/taur/drake
	icon = 'modular_gs/icons/mob/sprite_accessory/taur.dmi'

/datum/bodypart_overlay/mutant/taur_body
	var/taur_belly_size = 0

/datum/bodypart_overlay/mutant/taur_body/get_base_icon_state()
	if (istype(sprite_datum, /datum/sprite_accessory/taur/drake))
		return "drake_[taur_belly_size][laying_down ? "_laying" : ""]"

	return "[sprite_datum.icon_state][laying_down ? "_laying" : ""]"
