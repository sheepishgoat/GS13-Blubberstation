/// Length of time before the first auto storyteller vote is called (deciseconds, default 2 hours)
/// Set to 0 to disable the subsystem altogether.
/datum/config_entry/number/vote_autostoryteller_initial
	config_entry_value = 72000
	min_val = 0

///length of time to wait before subsequent autostoryteller votes (deciseconds, default 30 minutes)
/datum/config_entry/number/vote_autostoryteller_interval
	config_entry_value = 18000
	min_val = 0

/// Determines if the auto storyteller vote system runs or not.
/datum/config_entry/flag/autostoryteller
