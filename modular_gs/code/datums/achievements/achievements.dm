/datum/award/score/hardcore_fatty_total
	name = "Hardcore Fatty: Total Points Gained"
	desc = "You aren't in the room with the food, the food is in the room with you."
	database_id = HARDCORE_FATTY_SCORE

/datum/award/score/hardcore_fatty_streak
	name = "Hardcore Fatty: Biggest Point Streak"
	desc = "Either you are really good or really bad at managing your weight."
	database_id = HARDCORE_FATTY_STREAK_SCORE

/datum/award/score/hardcore_fatty_streak/unlock(mob/user, datum/achievement_data/holder, value = 1)
	if(value <= holder.data[type])
		return // Don't update unless we are beating the score.

	holder.data[type] = value

