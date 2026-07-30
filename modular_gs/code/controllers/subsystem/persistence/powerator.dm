#define POWERATOR_JSON_FILE "data/powerator.json"

/datum/controller/subsystem/persistence/proc/save_powerator_data()
	var/powerator_total_money_made = GLOB.powerator_total_cash_made
	var/powerator_money_made = GLOB.powerator_cash_made
	var/powerator_cash_modifier = GLOB.powerator_cash_modifier

	powerator_total_money_made += powerator_money_made

	if (powerator_total_money_made == 0)
		powerator_cash_modifier = POWERATOR_MAXIMUM_BONUS
	else
		powerator_cash_modifier = POWERATOR_MONEY_LIMIT / powerator_total_money_made
	powerator_total_money_made -= POWERATOR_MONEY_LIMIT
	powerator_total_money_made = max(0, powerator_total_money_made)
	GLOB.powerator_total_cash_made = powerator_total_money_made
	
	powerator_cash_modifier = clamp(powerator_cash_modifier, POWERATOR_MAXIMUM_PENALTY, POWERATOR_MAXIMUM_BONUS)
	GLOB.powerator_cash_modifier = powerator_cash_modifier

	var/datum/json_savefile/json_file = new /datum/json_savefile(POWERATOR_JSON_FILE)
	json_file.set_entry("powerator_money_modifier", powerator_cash_modifier)
	json_file.set_entry("powerator_total_cash_made", powerator_total_money_made)
	json_file.save()
	qdel(json_file)

/datum/controller/subsystem/persistence/proc/load_powerator_data()
	var/datum/json_savefile/json_file = new /datum/json_savefile(POWERATOR_JSON_FILE)
	var/powerator_total_money_made = json_file.get_entry("powerator_total_cash_made")
	var/powerator_money_modifier = json_file.get_entry("powerator_money_modifier")
	qdel(json_file)

	if (isnull(powerator_total_money_made))
		powerator_total_money_made = 0

	if (isnull(powerator_money_modifier))
		powerator_money_modifier = 1
	
	powerator_money_modifier = clamp(powerator_money_modifier, POWERATOR_MAXIMUM_PENALTY, POWERATOR_MAXIMUM_BONUS)
	powerator_total_money_made = max(0, powerator_total_money_made)
	
	GLOB.powerator_total_cash_made = powerator_total_money_made
	GLOB.powerator_cash_modifier = powerator_money_modifier

#undef POWERATOR_JSON_FILE
