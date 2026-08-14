/**
 * A carp which cannot teleport
 */
/mob/living/basic/carp/teleportless
	name = "teleportless space carp"
	desc = "A close relative of the space carp, which cannot teleport. Will still bite you."

/mob/living/basic/carp/teleportless/Initialize(mapload, mob/tamer)
	. = ..()
	ai_controller.clear_blackboard_key(BB_CARP_RIFT)
	QDEL_NULL(teleport)

/mob/living/basic/carp/mega/teleportless
	name = "space shark"
	desc = "A ferocious, fang bearing creature that resembles a shark. This one seems especially ticked off, but not enough to teleport."

/mob/living/basic/carp/mega/teleportless/Initialize(mapload)
	. = ..()
	ai_controller.clear_blackboard_key(BB_CARP_RIFT)
	QDEL_NULL(teleport)
