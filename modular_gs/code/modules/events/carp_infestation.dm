/datum/round_event_control/carp_migration/teleportless
	name = "Carp Infestation"
	description = "Same as the carp migration event, but the carps cannot teleport."
	weight = 15
	min_players = 10
	earliest_start = 10 MINUTES
	max_occurrences = 6
	typepath = /datum/round_event/carp_migration/teleportless

/datum/round_event/carp_migration/teleportless
	carp_type = /mob/living/basic/carp/teleportless
	boss_type = /mob/living/basic/carp/mega/teleportless
