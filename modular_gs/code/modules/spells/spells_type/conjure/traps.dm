/datum/action/cooldown/spell/conjure/the_traps/fattening
	name = "Fattening Traps!"
	desc = "Summon a number of traps around you. They will fatten any enemies that step on them."
	spell_requirements = NONE

	summon_type = list(
		/obj/structure/trap/fattening,
	)

/datum/action/cooldown/spell/conjure/the_traps/belch
	name = "Belch Traps!"
	desc = "Summon a number of traps around you. They will make any enemies that step on them belch."
	spell_requirements = NONE

	summon_type = list(
		/obj/structure/trap/belch,
	)

/datum/action/cooldown/spell/conjure/the_traps/gs13_random
	name = "Fattywank Traps!" 	// Put a name here if you can think of somethincg creative.
	spell_requirements = NONE

	summon_type = list( // List containing all of the current GS13 traps.
		/obj/structure/trap/fattening,
		/obj/structure/trap/belch,
	)
