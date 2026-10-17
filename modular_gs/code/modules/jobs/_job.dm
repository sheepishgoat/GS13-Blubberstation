/datum/job
	/// At what weight is someone locked out of playing this job, while hardcore fatty is enabled?
	var/max_hardcore_fatty_weight = FATNESS_LEVEL_BLOB // Most jobs aside from assistant are going to lock you out for being too fat.

/// Checks if the player is able to
/datum/job/proc/check_weight_restrictions(datum/preferences/prefs, player_key)
	if(!prefs || !max_hardcore_fatty_weight) // No reason to care.
		return TRUE

	if(!("Hardcore Fatty" in prefs.all_quirks))
		return TRUE

	// We need to read the modular persistence save and get info from it.
	var/player_ckey = ckey(player_key)
	var/json_file = file("data/player_saves/[player_ckey[1]]/[player_ckey]/modular_persistence.json")
	var/list/json = (fexists(json_file) ? json_decode(file2text(json_file)) : null)
	var/character_json = (islist(json) ? json["[prefs.default_slot]"] : null)

	if(!character_json)
		return TRUE

	var/total_weight = (character_json["real_fat"] + character_json["perma_fat"])
	if(total_weight > max_hardcore_fatty_weight)
		return FALSE

	return TRUE

