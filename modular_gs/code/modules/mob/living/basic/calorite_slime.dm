#define SLIME_TYPE_CALORITE "calorite"
#define COLOR_SLIME_CALORITE "#E4823F"

/datum/slime_type/calorite
	colour = SLIME_TYPE_CALORITE
	transparent = TRUE
	core_type = /obj/item/slime_extract/calorite
	mutations = list(
		/datum/slime_type/calorite = 1,
	)
	rgb_code = COLOR_SLIME_CALORITE

/mob/living/basic/slime/calorite
	icon = 'modular_gs/icons/mob/slimes.dmi'
	icon_state = "calorite-baby"
	ai_controller = /datum/ai_controller/basic_controller/slime/calorite
	slime_type = /datum/slime_type/calorite
	melee_damage_lower = 0
	melee_damage_upper = 0

/mob/living/basic/slime/calorite/reproduce()

	if(stat != CONSCIOUS)
		balloon_alert(src, "not conscious!")
		return

	if(!isopenturf(loc))
		balloon_alert(src, "not here!")

	if(life_stage != SLIME_LIFE_STAGE_ADULT)
		balloon_alert(src, "not adult!")
		return

	if(amount_grown < SLIME_EVOLUTION_THRESHOLD)
		balloon_alert(src, "need growth!")
		return

	var/list/friends_list = list()
	for(var/mob/living/basic/slime/friend in loc)
		if(QDELETED(friend))
			continue
		if(friend == src)
			continue
		friends_list += friend

	overcrowded = length(friends_list) >= SLIME_OVERCROWD_AMOUNT
	if(overcrowded)
		balloon_alert(src, "overcrowded!")
		return

	var/new_nutrition = floor(nutrition * 0.9)
	var/new_powerlevel = floor(powerlevel * 0.25)
	var/turf/drop_loc = drop_location()

	var/list/created_slimes = list(src)
	var/list/slime_friends = list()
	for(var/faction_member in faction)
		var/mob/living/possible_friend = locate(faction_member) in GLOB.mob_living_list
		if(QDELETED(possible_friend))
			continue
		slime_friends += possible_friend

	for(var/i in 1 to 3)
		var/mob/living/basic/slime/calorite/baby = new(drop_loc, /datum/slime_type/calorite)
		created_slimes += baby
		for(var/slime_friend in slime_friends)
			baby.befriend(slime_friend)

		SSblackbox.record_feedback("tally", "slime_babies_born", 1, baby.slime_type.colour)
		step_away(baby, src)

	set_nutrition(SLIME_STARTING_NUTRITION)
	for(var/mob/living/basic/slime/baby as anything in created_slimes)
		if(ckey) // Player slimes are more robust at spliting. Once an oversight of poor copypasta, now a feature!
			baby.set_nutrition(new_nutrition)
		baby.powerlevel = new_powerlevel
		if(mutation_chance)
			baby.mutation_chance = clamp(mutation_chance + rand(-5, 5), 0, 100)
		else
			baby.mutation_chance = 0

	set_life_stage(SLIME_LIFE_STAGE_BABY)
	set_slime_type(/datum/slime_type/calorite)
	amount_grown = 0
	mutator_used = FALSE

#define FEEDING_OFFSET "feeding"

//Changing the applied status while feeding to a custom one
/mob/living/basic/slime/calorite/start_feeding(mob/living/target_mob)
	target_mob.unbuckle_all_mobs(force = TRUE) //Slimes rip other mobs (eg: shoulder parrots) off (Slimes Vs Slimes is already handled in can_feed_on())

	if(target_mob.buckle_mob(src, force = TRUE))
		add_offsets(FEEDING_OFFSET, y_add = target_mob.mob_size <= MOB_SIZE_SMALL ? 0 : 3)
		layer = MOB_ABOVE_PIGGYBACK_LAYER //appear above the target mob
		target_mob.apply_status_effect(/datum/status_effect/slime_leech/calorite, src) //Changed status

		target_mob.visible_message(
			span_danger("[name] latches onto [target_mob]!"),
			span_userdanger("[name] latches onto [target_mob]!"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		to_chat(src, span_notice("<i>I start feeding on [target_mob]...</i>"))
		balloon_alert(src, "feeding started")

	else
		balloon_alert(src, "latch failed!")

//If for some reason the slime is trying to attack a human then let's make it deal fat damage instead
/mob/living/basic/slime/calorite/on_slime_pre_attack(mob/living/basic/slime/our_slime, atom/target, proximity, modifiers)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		human_target.visible_message(span_danger("\The [our_slime] feeds [human_target]!"), span_userdanger("\The [our_slime] feeds you!"))
		human_target.apply_damage(our_slime.powerlevel, FAT, spread_damage = TRUE, wound_bonus = CANT_WOUND)
	else
		.=..()

//Slight change to AI so it will immediately begin feeding on humans
/datum/ai_controller/basic_controller/slime/calorite
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/change_slime_face,
		/datum/ai_planning_subtree/use_mob_ability/evolve,
		/datum/ai_planning_subtree/use_mob_ability/reproduce,
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/find_and_hunt_target/find_slime_food/calorite,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/slime,
		/datum/ai_planning_subtree/random_speech/slime,
	)

//New behavior when interacting with humans
/datum/ai_planning_subtree/find_and_hunt_target/find_slime_food/calorite
	hunting_behavior = /datum/ai_behavior/hunt_target/interact_with_target/slime/calorite

//Immediately begin feeding on valid human targets
/datum/ai_behavior/hunt_target/interact_with_target/slime/calorite/target_caught(mob/living/basic/slime/hunter, mob/living/hunted)
	if(ishuman(hunted))
		if(hunter.can_feed_on(hunted))
			hunter.start_feeding(hunted)
		return

	. = ..()

/atom/movable/screen/alert/status_effect/slime_leech/calorite
	name = "Calorite Slime Feeding"
	desc = "A calorite slime has latched onto your mouth and is feeding itself to you!"
	icon_state = "slime_leech"

/datum/status_effect/slime_leech/calorite
	id = "slime_leech"
	alert_type = /atom/movable/screen/alert/status_effect/slime_leech/calorite

//If our target is a human we do our custom behavior. Otherwise it'll be business as usual so it doesn't try to fatten monkeys
/datum/status_effect/slime_leech/calorite/tick(seconds_between_ticks)
	if(ishuman(owner))
		if(owner.stat == DEAD)
			our_slime.stop_feeding(silent = TRUE)
			return
		var/mob/living/carbon/human/human_owner = owner

		var/damage = (rand(2,4) + our_slime.powerlevel) * seconds_between_ticks

		human_owner.adjust_nutrition(-damage)
		human_owner.adjust_fatness(damage, FATTENING_TYPE_MOBS)

		if(prob(5))
			var/static/list/pain_lines
			if(isnull(pain_lines))
				pain_lines = list(
					"You gulp down more slime!",
					"The slime keeps forcing itself down your throat!",
				)
				to_chat(owner, span_userdanger(pick(pain_lines)))

		our_slime.adjust_nutrition(1.8 * damage)
		our_slime.adjustBruteLoss(-1.5 * seconds_between_ticks)
		return

	. = ..()

/datum/status_effect/slime_leech/calorite/on_buckle_end()

	var/bio_protection = 100 - owner.getarmor(null, BIO)
	if(prob(bio_protection))
		owner.apply_status_effect(/datum/status_effect/slimed/calorite, our_slime.slime_type.rgb_code, our_slime.slime_type.colour == SLIME_TYPE_RAINBOW)

	UnregisterSignal(our_slime, list(COMSIG_LIVING_DEATH, COMSIG_MOB_UNBUCKLED, COMSIG_QDELETING,))
	if(!QDELETED(our_slime))
		our_slime.stop_feeding()

	qdel(src)

/atom/movable/screen/alert/status_effect/slimed/calorite
	name = "Covered in Calorite Slime"
	desc = "You are covered in calorite slime! Click to start cleaning it off, or find a faster way to wash it away!"

/datum/status_effect/slimed/calorite
	alert_type = /atom/movable/screen/alert/status_effect/slimed/calorite

/// The minimum amount of water stacks needed to start washing off the slime.
#define MIN_WATER_STACKS 5
/// The minimum amount of health a mob has to have before the status effect is removed.
#define MIN_HEALTH 10
//Tweaking the effect to do fat stuff with humans but retain its base functionalities on other mobs
/datum/status_effect/slimed/calorite/tick(seconds_between_ticks)
	// remove from the mob once we have dealt enough damage
	if(owner.get_organic_health() <= MIN_HEALTH)
		to_chat(owner, span_warning("You feel the layer of slime crawling off of your weakened body."))
		qdel(src)
		return

	// handle washing slime off
	var/datum/status_effect/fire_handler/wet_stacks/wetness = locate() in owner.status_effects
	if(istype(wetness) && wetness.stacks > (MIN_WATER_STACKS * seconds_between_ticks))
		wetness.adjust_stacks(-5 * seconds_between_ticks)
		remove_stacks(seconds_between_ticks) // 1 per second
		if(slime_stacks <= 0)
			return
	//Custom behavior for calorite slimes if the owner is a human
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.adjust_fatness(rand(2,4) * seconds_between_ticks, FATTENING_TYPE_MOBS)
		remove_stacks(seconds_between_ticks)
		if(prob(10))
			to_chat(human_owner, span_userdanger("You feel your body growing in contact with the slime."))
		return
	// otherwise deal brute damage
	owner.apply_damage(rand(2,4) * seconds_between_ticks, damagetype = BRUTE)

	if(SPT_PROB(10, seconds_between_ticks))
		var/feedback_text = pick(list(
			"Your entire body screams with pain",
			"Your skin feels like it's coming off",
			"Your body feels like it's melting together"
		))
		to_chat(owner, span_userdanger("[feedback_text] as the layer of slime eats away at you!"))

/obj/item/slime_extract/calorite
	name = "calorite slime extract"
	icon = 'modular_gs/icons/mob/slimes.dmi'
	icon_state = "calorite-core"
	//crossbreed_modification = "symbiont" - Let's not do crossbred cores JUST yet
	activate_reagents = list(/datum/reagent/toxin/plasma)

/obj/item/slime_extract/calorite/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)

		if(SLIME_ACTIVATE_MINOR)
			user.reagents.add_reagent(/datum/reagent/consumable/lipoifier, 5)
			to_chat(user, span_notice("Your body generates a little lipoifier."))
			return 60

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_notice("Your [name] starts pulsing..."))
			if(do_after(user, 4 SECONDS, target = user))
				var/mob/living/basic/slime/calorite/spawning_slime = new(get_turf(user), /datum/slime_type/calorite)
				playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
				spawning_slime.visible_message(span_danger("A new calorite slime grows out of you!"))
				return 360

			else
				return 0

/datum/chemical_reaction/slime/calorite_plasma
	results = list(/datum/reagent/consumable/lipoifier = 5)
	required_reagents = list(/datum/reagent/toxin/plasma = 5)
	required_container = /obj/item/slime_extract/calorite

/obj/item/slimecross/Initialize(mapload)
	. = ..()
	if(colour == SLIME_TYPE_CALORITE)
		add_atom_colour(COLOR_SLIME_CALORITE, FIXED_COLOUR_PRIORITY)

//Reproductive crossbreed
/obj/item/slimecross/reproductive/calorite
	extract_type = /obj/item/slime_extract/calorite
	colour = SLIME_TYPE_CALORITE

//Burning crossbreed
/obj/item/slimecross/burning/calorite
	colour = SLIME_TYPE_CALORITE
	effect_desc = "Expels a lipoifier cloud in a radius."

/obj/item/slimecross/burning/calorite/do_effect(mob/user)
	user.visible_message(span_danger("[src] boils over, releasing blubbery gas!"))
	var/datum/reagents/tmp_holder = new/datum/reagents(100)
	tmp_holder.add_reagent(/datum/reagent/consumable/lipoifier, 10)

	var/datum/effect_system/fluid_spread/smoke/chem/smoke = new
	smoke.set_up(7, holder = src, location = get_turf(user), carry = tmp_holder)
	smoke.start(log = TRUE)
	..()

//Regenerative crossbreed
/obj/item/slimecross/regenerative/calorite
	colour = SLIME_TYPE_CALORITE
	effect_desc = "Fully heals the target and fattens them up."
	var/fatness_stored = 100

/obj/item/slimecross/regenerative/calorite/core_effect_before(mob/living/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		fatness_stored += human_target.fatness_real
		human_target.adjust_fatness(50, FATTENING_TYPE_ITEM)

/obj/item/slimecross/regenerative/calorite/core_effect(mob/living/carbon/human/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		human_target.adjust_fatness(fatness_stored, FATTENING_TYPE_ITEM, TRUE)

//Stabilized crossbreed
/obj/item/slimecross/stabilized/calorite
	colour = SLIME_TYPE_CALORITE
	effect_desc = "Passively fattens up the user."

/datum/status_effect/stabilized/calorite
	id = "stabilizedcalorite"
	colour = SLIME_TYPE_CALORITE

/datum/status_effect/stabilized/calorite/tick(seconds_between_ticks)
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.adjust_fatness(3, FATTENING_TYPE_ITEM)
	return ..()

//Industrial crossbreed
/obj/item/slimecross/industrial/calorite
	colour = SLIME_TYPE_CALORITE
	effect_desc = "Produces edible random food and drink items."
	plasmarequired = 5

/obj/item/slimecross/industrial/calorite/process()
	itempath = pick(list(get_random_food(), get_random_drink()))
	..()

//Charged crossbreed
/obj/item/slimecross/charged/calorite
	colour = SLIME_TYPE_CALORITE
	effect_desc = "Produces an expansion potion, which helps you both gain and lose weight."

/obj/item/slimecross/charged/calorite/do_effect(mob/user)
	new /obj/item/slimepotion/weightratepotions(get_turf(user))
	user.visible_message(span_notice("[src] distills into a potion!"))
	..()

/obj/item/slimepotion/weightratepotions
	name = "expansion potion"
	desc = "A solution of chemicals adapts the drinker to gain and lose weight much more easily."
	icon = 'modular_gs/icons/obj/chemical.dmi'
	icon_state = "potcalorite"

/obj/item/slimepotion/weightratepotions/attack(mob/living/target, mob/user)
	if(!ishuman(target))
		return ..()

	if(!do_after(user, 10 SECONDS, target = target))
		return
	var/mob/living/carbon/human/human_target = target
	if(human_target.get_weight_gain_modifier("calorite_slime") < 5.0)
		human_target.add_weight_gain_modifier("calorite_slime", 0.5)
	if(human_target.get_weight_loss_modifier("calorite_slime") < 5.0)
		human_target.add_weight_loss_modifier("calorite_slime", 0.5)
	qdel(src)

//Self-sustaining crossbreed
/obj/item/slimecross/selfsustaining/calorite
	extract_type = /obj/item/slime_extract/calorite
	colour = SLIME_TYPE_CALORITE

//Chilling crossbreed
/obj/item/slimecross/chilling/calorite
	colour = SLIME_TYPE_CALORITE
	effect_desc = "Creates a piece of calorite ore."

/obj/item/slimecross/chilling/calorite/do_effect(mob/user)
	user.visible_message(span_notice("[src] produces a piece of calorite ore!"))
	new /obj/item/stack/ore/calorite(get_turf(user))
	..()

//Consuming crossbreed
/obj/item/slimecross/consuming/calorite
	colour = SLIME_TYPE_CALORITE
	effect_desc = "Creates a calorite slime cookie."
	cookietype = /obj/item/slime_cookie/calorite

/obj/item/slime_cookie/calorite
	name = "calorite slime cookie"
	desc = "Immensely nutritious, certainly."
	icon = 'modular_gs/icons/obj/slimecookies.dmi'
	icon_state = "calorite"
	taste = "goo"
	nutrition = 50

//Recurring crossbreed
/obj/item/slimecross/recurring/calorite
	extract_type = /obj/item/slime_extract/calorite
	colour = SLIME_TYPE_CALORITE
	max_cooldown = 36

//Prismatic crossbreed
/obj/item/slimecross/prismatic/calorite
	paintcolor = "#E4823F"
	colour = SLIME_TYPE_CALORITE

//Reaction to spawn a calorite slime when a grey extratc is injected with lipoifier
/datum/chemical_reaction/slime/caloriteslimespawn
	required_reagents = list(/datum/reagent/consumable/lipoifier = 10)
	required_container = /obj/item/slime_extract/grey

/datum/chemical_reaction/slime/caloriteslimespawn/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/mob/living/basic/slime/calorite/spawning_slime = new(get_turf(holder.my_atom), /datum/slime_type/calorite)
	spawning_slime.visible_message(span_danger("Infused with lipoifier, the core begins to quiver and grow, a calorite slime is born."))
	..()


/mob/living/basic/slime/click_ctrl(mob/user)
	if(ishuman(user) && user.pulling == src && user.grab_state == GRAB_AGGRESSIVE)
		var/mob/living/carbon/human/human_user = user
		if(human_user.has_quirk(/datum/quirk/slime_eater))
			if(!do_after(human_user, 5 SECONDS, target = src))
				return
			human_user.reagents.add_reagent(/datum/reagent/toxin/slimejelly, health)
			if(istype(src, /mob/living/basic/slime/calorite))
				human_user.reagents.add_reagent(/datum/reagent/toxin/slimejelly, health)
			qdel(src)

/datum/reagent/toxin/slimejelly/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(affected_mob.has_quirk(/datum/quirk/slime_eater))
		if(SPT_PROB(23, seconds_per_tick))
			if(affected_mob.heal_bodypart_damage(5))
				return UPDATE_MOB_HEALTH
		affected_mob.adjust_nutrition(6 * seconds_per_tick)
		return
	. = ..()
