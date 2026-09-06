GLOBAL_LIST_INIT(no_random_cure_symptoms, list(/datum/symptom/berry, /datum/symptom/weight_gain,))

/datum/symptom/berry
	name = "Berrification"
	desc = "The virus causes the host's biology to overflow with a blue substance. Infection ends if the substance is completely removed from their body, besides ordinary cures."
	stealth = -5
	resistance = -4
	stage_speed = 1
	transmittable = 6
	level = 7
	severity = 4
	base_message_chance = 100
	symptom_delay_min = 15
	symptom_delay_max = 45
	threshold_descs = list(
		"Stage Speed" = "Increases the rate of liquid production.",
	)
	var/datum/reagent/infection_reagent = /datum/reagent/blueberry_juice

/datum/symptom/berry/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.affected_mob?.client?.prefs?.read_preference(/datum/preference/toggle/blueberry_inflation))
		A.affected_mob.reagents.add_reagent(infection_reagent, max(1, A.totalStageSpeed()) * 10)
		// Start blueberry loop
		A.affected_mob.blueberry_inflate_loop.start()
	..()

/datum/symptom/berry/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	if(!(M?.client?.prefs?.read_preference(/datum/preference/toggle/blueberry_inflation)))
		return
	if(M.reagents.get_reagent_amount(infection_reagent) <= 0)
		A.remove_disease()
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(M, "<span class='warning'>[pick("You feel oddly full...", "Your stomach churns...", "You hear a gurgle...", "You taste berries...")]</span>")
		else
			to_chat(M, "<span class='warning'><i>[pick("A deep slosh comes from inside you...", "Your mind feels light...", "You think blue really suits you...", "Your skin feels so tight...")]</i></span>")
	M.reagents.add_reagent(infection_reagent, (max(A.totalStageSpeed(), 0.2)) * A.stage)

/obj/item/reagent_containers/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.combat_mode || !ishuman(interacting_with))
		return ..()

	var/mob/living/carbon/human/berry = interacting_with
	if(berry.reagents.get_reagent_amount(/datum/reagent/blueberry_juice) <= 0)
		return ..()

	while(in_range(user, berry) && berry.reagents.get_reagent_amount(/datum/reagent/blueberry_juice) > 0 && reagents.total_volume < reagents.maximum_volume && do_after(user, 1 SECONDS, berry))
		var/move_volume = min(berry.reagents.get_reagent_amount(/datum/reagent/blueberry_juice), min(10,amount_per_transfer_from_this), reagents.maximum_volume - reagents.total_volume)
		reagents.add_reagent(/datum/reagent/blueberry_juice, move_volume)
		berry.reagents.remove_reagent(/datum/reagent/blueberry_juice, move_volume)
		if(berry != user)
			to_chat(user, "<span class='warning'>You juice [berry.name]...</span>")
			to_chat(berry, "<span class='warning'>[user.name] juices you...</span>")
		else
			to_chat(user, "<span class='warning'>You get some juice out of you...</span>")

/*
/obj/effect/decal/cleanable/blood/update_icon()
	color = blood_DNA_to_color()
	if(blood_state == BLOOD_STATE_JUICE)
		color = BLOOD_COLOR_JUICE
*/
