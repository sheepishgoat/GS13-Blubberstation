#define CHOICE_TRANSFER "Initiate Crew Transfer"
#define CHOICE_CONTINUE "Continue Playing"

/datum/vote/reset()
	reminder_fired = FALSE
	return ..()

/datum/vote/transfer_vote
	vote_reminder = TRUE
	force_open_panel_on_reminder = TRUE

/datum/vote/transfer_vote/tiebreaker(list/winners)
	return CHOICE_CONTINUE

#undef CHOICE_TRANSFER
#undef CHOICE_CONTINUE
