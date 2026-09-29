//advertising sign
/obj/item/holosign_creator/gatofood_ad
	name = "GATO advertisment projector"
	desc = "A holographic projector that creates holographic signs, advertising the local GATO restaurant."
	holosign_type = /obj/structure/holosign/barrier/gatofood_ad
	creation_time = 4
	max_signs = 8
	projectable_through = list(
		/obj/machinery/door,
		/obj/structure/mineral_door,
		/obj/structure/window,
		/obj/structure/grille,
	)

/obj/structure/holosign/barrier/gatofood_ad
	name = "Holosign - 'GATO Fast Food is currently OPEN!'"
	desc = "A holographic projection advertising the nearby GATO fast food restaurant. Why don't you visit?"
	icon = 'modular_gs/icons/effects/holosigns.dmi'
	icon_state = "holo_gatofood"
	base_icon_state = "holo_gatofood"
	openable = FALSE
	density = FALSE
	anchored = TRUE
	can_atmos_pass = ATMOS_PASS_YES
	alpha = 150
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

//closed sign - maybe printable by Service in the future?
/obj/item/holosign_creator/gatofood_ad/closed
	name = "Closure sign projector"
	icon_state = "signmaker_sec"
	desc = "A holographic projector that creates holographic signs for closing an establishment. You can't run through, but you can walk through them."
	holosign_type = /obj/structure/holosign/barrier/gatofood_ad/closed

/obj/structure/holosign/barrier/gatofood_ad/closed
	name = "Holosign - 'WE ARE CLOSED!'"
	desc = "A holographic projection informing that this establishment is closed."
	icon_state = "holo_closed"
	base_icon_state = "holo_closed"
	density = TRUE
	allow_walk = TRUE
