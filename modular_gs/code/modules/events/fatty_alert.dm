/datum/round_event_control/fatty_alert
	name = "Blob crew alert"
	description = "Selects a fat crewmember and shames them on comms by mistaking them for a blob. The fatter the crewmate the higher the chance. Perma fat is more valuable."
	typepath = /datum/round_event/fatty_alert
	category = EVENT_CATEGORY_BUREAUCRATIC
	weight = 10
	max_occurrences = 1
	min_players = 7	// actually want to have some pop to chose from
	earliest_start = 30 MINUTES

	tags = list(TAG_NEUTRAL)
	track = EVENT_TRACK_MUNDANE

/datum/round_event/fatty_alert
	fakeable = TRUE

/datum/round_event/fatty_alert/announce(fake)
	priority_announce("Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_OUTBREAK5)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(lose_some_weight_lardass)), rand(60 SECONDS, 180 SECONDS))
