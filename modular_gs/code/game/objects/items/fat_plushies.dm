#define PLUSHIE_FOOD_VALUE 1
#define PLUSHIE_VORE_VALUE 4
#define PLUSHIE_DIGESTION_TIME_VORE 5 MINUTES
#define PLUSHIE_DIGESTION_TIME_FOOD 2.5 MINUTES

/obj/item/toy/plush
	/// What is the default icon state? This is automatically set on init.
	var/default_icon_state
	/// Do we have fat while something is inside?
	var/stuffed_icon_state

	/// Is our plushie a mean plushie that eats other plushies?
	var/pred_plush = FALSE
	/// Can our plushie be eaten by pred plushes?
	var/prey_plush = FALSE

	/// Can our plushie eat food?
	var/can_eat_food = FALSE

	/// How much has this one eaten?
	var/fatness = 0
	/// Fatness to get to max size.
	var/fatness_to_max = 20
	/// What is the max scale we can get our plushie?
	var/max_plushie_scale = 2
	/// What is the value of the last digested item?
	var/last_item_value = 0
	/// How many plushies have we devoured?
	var/devoured_plushies = 0
	/// Are we currently digesting something?
	var/currently_digesting = FALSE
	/// What can the plushie eat that aren't other plushes?
	var/list/edible_object_types = list(/obj/item/food, /obj/item/stack/sheet/cotton)
	/// How effecient is the plush at processing food? Divide digestion time by this value.
	var/digestion_divider = 1

/obj/item/toy/plush/proc/devour_item(obj/item/item_to_devour, mob/living/user)
	if(currently_digesting)
		to_chat(span_warning("[src] seems full right now..."))
		return FALSE

	var/can_eat = FALSE
	for(var/type as anything in edible_object_types)
		if(istype(item_to_devour, type))
			can_eat = TRUE
			break

	var/obj/item/toy/plush/devoured_plush = item_to_devour
	if(istype(devoured_plush) && devoured_plush?.prey_plush)
		can_eat = TRUE

	if(!can_eat)
		to_chat(span_warning("[src] seems to be unable to eat [item_to_devour]!"))
		return FALSE

	var/digestion_value = PLUSHIE_FOOD_VALUE
	var/digestion_time = PLUSHIE_DIGESTION_TIME_FOOD

	if(istype(devoured_plush))
		digestion_value = PLUSHIE_VORE_VALUE
		digestion_time = PLUSHIE_DIGESTION_TIME_VORE
		if(devoured_plush.fatness > digestion_value)
			digestion_value += devoured_plush.fatness

		devoured_plushies += (1 + devoured_plush?.devoured_plushies)

	to_chat(user, span_notice("[src] devours the [item_to_devour]!"))
	digestion_time = (digestion_time / digestion_divider)

	last_item_value = digestion_value
	qdel(item_to_devour) // It's gone, you monster.
	if(stuffed_icon_state)
		icon_state = stuffed_icon_state

	addtimer(CALLBACK(src, PROC_REF(finish_digestion)), digestion_time)
	return TRUE

/obj/item/toy/plush/proc/finish_digestion()
	if(!last_item_value)
		return FALSE

	icon_state = default_icon_state
	fatness += last_item_value
	visible_message(span_notice("[src] seems to get fatter..."))
	last_item_value = 0

	update_scale()
	return TRUE

/obj/item/toy/plush/proc/update_scale()
	var/scaling = 1
	// Math stuff for nerds.
	scaling += (fatness * ((max_plushie_scale - 1) / fatness_to_max))
	scaling = min(scaling, max_plushie_scale) // We don't want them to get larger

	var/matrix/M = matrix()
	transform = M.Scale(scaling)
	return TRUE

/obj/item/toy/plush/proc/attempt_to_feed(obj/item/item_to_feed, mob/living/user)
	if(!is_type_in_list(item_to_feed, edible_object_types) && !istype(item_to_feed, /obj/item/toy/plush))
		return FALSE

	devour_item(item_to_feed, user)
	return TRUE


/obj/item/toy/plush/examine(mob/user)
	. = ..()
	if(can_eat_food)
		. += span_notice("[src] is somehow able to eat food.")

	if(fatness)
		. += span_notice("[src] seems rather huggable.")
	if(devoured_plushies)
		if(devoured_plushies == 1)
			. += span_abductor("[src] has a single tally on them.")
		else
			. += span_abductor("[src] has [devoured_plushies] tallies on them.")

	if(pred_plush)
		if(prey_plush)
			. += span_abductor("[src] seems like it can devour and be devoured by certain other plushies.")
		else
			. += span_abductor("[src] seems like it can devour certain other plushies.")

	else if(prey_plush)
		. += span_abductor("[src] seems like it can be devoured by certain other plushies.")

