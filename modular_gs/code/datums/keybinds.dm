// the full type is a mouthful. have a define to make it shorter
#define MASTER_WG_PREF_TYPE /datum/preference/toggle/master_wg_pref

/datum/keybinding/client/toggle_master_wg_pref
	full_name = "Toggle master WG pref"
	name = "toggle_master_wg_pref"
	description = "Toggles the master WG pref on and off."
	keybind_signal = "toggle_master_wg_pref_keybind"	// too lazy to make a define since I don't need one actually

/datum/keybinding/client/toggle_master_wg_pref/down(client/user, turf/target, mousepos_x, mousepos_y)
	if (isnull(user.prefs))
		return

	var/old_pref = user.prefs.read_preference(MASTER_WG_PREF_TYPE)
	var/datum/preference/toggle/master_wg_pref/master_wg_pref = GLOB.preference_entries[MASTER_WG_PREF_TYPE]
	user.prefs.write_preference(master_wg_pref, !old_pref)
	to_chat(user, span_notice("The master WG switch is now [old_pref ? "disabled" : "enabled"]."))

	return ..()

#undef MASTER_WG_PREF_TYPE
