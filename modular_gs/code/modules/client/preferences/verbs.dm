#define MASTER_WG_PREF_TYPE /datum/preference/toggle/master_wg_pref

GAME_VERB(/mob/living/carbon, toggle_master_wg_pref, "Toggle Master WG Pref", "OOC")

	if (isnull(client) || isnull(client.prefs))
		return

	var/datum/preferences/prefs = client.prefs

	var/old_pref = prefs.read_preference(MASTER_WG_PREF_TYPE)
	var/datum/preference/toggle/master_wg_pref/master_wg_pref = GLOB.preference_entries[MASTER_WG_PREF_TYPE]
	prefs.write_preference(master_wg_pref, !old_pref)
	to_chat(src, span_notice("The master WG switch is now [old_pref ? "disabled" : "enabled"]."))

#undef MASTER_WG_PREF_TYPE
