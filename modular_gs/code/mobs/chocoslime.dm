
/datum/ai_controller/basic_controller/feedermob
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/feedermob,
		BB_TARGET_MINIMUM_STAT = UNCONSCIOUS,
		BB_EMOTE_KEY = "glunk",
		BB_EMOTE_CHANCE = 40,
	)

	behavior_tree_json = "modular_gs/code/mobs/feeder_mob.bt.json"

	ai_traits = DEFAULT_AI_FLAGS | STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	// idle_behavior = /datum/idle_behavior/idle_random_walk

	// planning_subtrees = list(
	// 	/datum/ai_planning_subtree/escape_captivity,
	// 	/datum/ai_planning_subtree/simple_find_target,
	// 	/datum/ai_planning_subtree/basic_melee_attack_subtree,
	// )

/datum/targeting_strategy/feedermob/is_valid_target(mob/living/living_mob, atom/target, vision_range, datum/ai_controller/controller = null)
	if isanimal_or_basicmob(target)
		return FALSE
	
	if(!..())
		return FALSE
	
	return ishuman(target)

/mob/living/simple_animal/hostile/feed
	var/food_per_feeding = 5
	var/food_fed = /datum/reagent/consumable/nutriment

/mob/living/simple_animal/hostile/feed/CanAttack(atom/the_target)
	var/mob/living/carbon/target = the_target
	if(!istype(the_target)|| !check_target_prefs(target))
		return FALSE

	return ..()

/// Called when seeing if a target can be attacked. See if the target has the pref on and return accordingly.
/mob/living/simple_animal/hostile/proc/check_target_prefs(mob/living/carbon/target)
	if(!istype(target))
		return FALSE
	if(isnull(target.client))
		return FALSE
	if(isnull(target.client.prefs))
		return FALSE

	var/datum/preferences/preferences = target.client.prefs

	// return target?.client?.prefs?.weight_gain_weapons
	return preferences.read_preference(/datum/preference/toggle/weight_gain_weapons) || HAS_TRAIT(target, TRAIT_UNIVERSAL_GAINER)

/mob/living/simple_animal/hostile/feed/AttackingTarget(atom/target)
	. = ..()
	if(!iscarbon(target))
		return FALSE


	var/mob/living/carbon/soon_to_be_fatty = target

	var/obj/item/organ/stomach/belly = soon_to_be_fatty.get_organ_slot(ORGAN_SLOT_STOMACH)

	if(!belly)
		return FALSE

	if(soon_to_be_fatty.is_mouth_covered())
		return FALSE

	belly.reagents.add_reagent(food_fed, food_per_feeding)

/mob/living/simple_animal/hostile/feed/chocolate_slime
	name = "Chocolate slime"
	desc = "It's a living blob of tasty chocolate!"
	icon = 'modular_gs/icons/mob/candymonster.dmi'
	icon_state = "a_c_slime"
	icon_living = "a_c_slime"
	icon_dead = "a_c_slime_dead"
	ai_controller = /datum/ai_controller/basic_controller/feedermob
	speak_emote = list("blorbles")
	emote_hear = list("blorbles")
	speak_chance = 5
	turns_per_move = 5
	see_in_dark = 10
	butcher_results = list(/obj/item/food/chocolatebar = 4)
	maxHealth = 100
	health = 100
	obj_damage = 0
	melee_damage_lower = 0.001
	melee_damage_upper = 0.001
	pass_flags = PASSTABLE
	move_to_delay = 7
	attack_sound = 'sound/items/eatfood.ogg'
	faction = list(ROLE_WIZARD, FACTION_FEEDER, FACTION_SLIME)
	unique_name = 1
	gold_core_spawnable = HOSTILE_SPAWN
	see_in_dark = 3
	blood_volume = 0
	// lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	lighting_cutoff = LIGHTING_CUTOFF_LOW
	initial_language_holder = /datum/language_holder/slime
	digestion_fat_yield = 1500
	// vore_flags = DEVOURABLE | DIGESTABLE | FEEDING

//Creambeast - basically a bit tougher mob that has feeding ranged attacks
/mob/living/simple_animal/hostile/feed/chocolate_slime/creambeast
	name = "Creambeast"
	desc = "A strange mass of thick, creamy ice cream given some sense of instinct."
	icon_state = "icecream_monster"
	icon_living = "icecream_monster"
	icon_dead = "icecream_monster_dead"
	icon_gib = "icecream_monster_dead"
	move_to_delay = 10
	projectiletype = /obj/projectile/beam/fattening/icecream
	projectilesound = 'sound/items/weapons/pierce.ogg'
	faction = list(ROLE_WIZARD, FACTION_FEEDER)
	ranged = 1
	ranged_message = "schlorps"
	ranged_cooldown_time = 30
	vision_range = 2
	speed = 3
	maxHealth = 100
	health = 100
	obj_damage = 0
	vision_range = 2
	aggro_vision_range = 9
	turns_per_move = 5
	blood_volume = 0
	digestion_fat_yield = 1500
	gold_core_spawnable = HOSTILE_SPAWN
	butcher_results = list(/obj/item/food/icecreamsandwich = 4)

/obj/projectile/beam/fattening/icecream //might as well make use of this thing to not make ton of different variants of the same thing
	name = "ice cream blob"
	icon = 'modular_gs/icons/mob/candymonster.dmi'
	icon_state = "icecream_projectile"
	ricochets_max = 0
	ricochet_chance = 0
	hitsound = 'sound/items/weapons/tap.ogg'
	hitsound_wall = 'sound/items/weapons/tap.ogg'
	reflectable = FALSE
	light_range = 0
	var/food_per_feeding = 5
	var/food_fed = /datum/reagent/consumable/nutriment
	var/fullness_add = 30

/obj/projectile/beam/fattening/icecream/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/mob/living/carbon/L = target
	if(!istype(L) || !L.reagents || L.is_mouth_covered(ITEM_SLOT_HEAD))
		return FALSE

	L.reagents.add_reagent(food_fed, food_per_feeding)
	if(HAS_TRAIT(L, TRAIT_VORACIOUS))
		fullness_add = fullness_add * 0.67
	L.fullness += (fullness_add)



//should probably put this in elsewhere or whatever, but for now it'll do

/mob/living/simple_animal/hostile/fatten
	var/fat_per_hit = 20

/mob/living/simple_animal/hostile/fatten/magehand
	name = "Magehand"
	desc = "It's a floating mage hand of strange, crackling orange energy..."
	icon = 'modular_gs/icons/mob/fathand.dmi'
	icon_state = "fathand"
	icon_living = "fathand"
	icon_dead = "fathand_dead"
	ai_controller = /datum/ai_controller/basic_controller/feedermob
	speak_emote = list("crackles")
	emote_hear = list("crackles")
	speak_chance = 5
	mob_biotypes = MOB_SPIRIT
	pressure_resistance = 9000
	turns_per_move = 5
	aggro_vision_range = 10
	see_in_dark = 10
	maxHealth = 20
	health = 20
	obj_damage = 0
	melee_damage_lower = 0.001
	melee_damage_upper = 0.001
	blood_volume = 0 //don't want it to bleed
	del_on_death = TRUE //it's an apparition, shouldn't have a body
	movement_type = FLYING
	attack_verb_continuous = "pokes"
	attack_verb_simple = "pokes"
	// a_intent = INTENT_HARM
	pass_flags = PASSTABLE
	move_to_delay = 2 //very fast
	attack_sound = 'sound/items/weapons/pulse.ogg'
	unique_name = 1
	lighting_cutoff = LIGHTING_CUTOFF_LOW
	// atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 0
	minbodytemp = 0
	maxbodytemp = INFINITY
	faction = list(ROLE_WIZARD, FACTION_FEEDER)

/mob/living/simple_animal/hostile/fatten/AttackingTarget(atom/attacked_target)
	. = ..()
	var/mob/living/carbon/carbon = attacked_target
	if(!istype(carbon))
		return FALSE

	carbon.adjust_fatness(fat_per_hit, FATTENING_TYPE_MOBS)

/mob/living/simple_animal/hostile/fatten/CanAttack(atom/the_target)
	var/mob/living/carbon/target = the_target
	if(!istype(the_target)|| !check_target_prefs(target))
		return FALSE

	return ..()

/mob/living/simple_animal/hostile/fatten/check_target_prefs(mob/living/carbon/target)
	if(!istype(target))
		return FALSE
	if(isnull(target.client))
		return FALSE
	if(isnull(target.client.prefs))
		return FALSE

	var/datum/preferences/preferences = target.client.prefs

	// return target?.client?.prefs?.weight_gain_weapons
	return preferences.read_preference(/datum/preference/toggle/weight_gain_magic) || HAS_TRAIT(target, TRAIT_UNIVERSAL_GAINER)
