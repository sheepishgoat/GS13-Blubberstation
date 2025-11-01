/datum/interaction/breast_feed_self
	name = "Breast feed self"
	description = "Feed yourself using your breasts"
	user_messages = list("You lift your breasts to your mouth and begin sucking...")
	category = "Sex"
	usage = INTERACTION_SELF
	lewd = TRUE	// truth nuke
	user_required_parts = list(ORGAN_SLOT_BREASTS)
	user_pleasure = 1
	user_arousal = 2
	interaction_requires = list(INTERACTION_REQUIRE_SELF_HAND)
	color = ""
	// sexuality = 