/obj/item/organ/taur_body/proc/set_size_from_weight(size_change)
	if (mutantpart_info[MUTANT_INDEX_NAME] != "drake")
		stack_trace("set_size_from_weight on a taur body called on a taur that's not a drake.")
		return

	if (size_change == 0)
		bodypart_overlay.sprite_datum.icon = initial(bodypart_overlay.sprite_datum.icon)
		bodypart_overlay.sprite_datum.icon_state = initial(bodypart_overlay.sprite_datum.icon_state)
		return

	// bodypart_overlay.sprite_datum.icon = ""
	bodypart_overlay.sprite_datum.icon_state = "drake_[size_change]"

