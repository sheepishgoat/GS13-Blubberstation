/obj/item/portable_blender
	name = "portable blender"
	desc = "Perfect for grinding food up into an unrecognizable paste! Will not work with non-foods!"
	icon = 'modular_gs/icons/obj/items/blender.dmi' //Sprites made by @greeenwoman
	icon_state = "blender"
	base_icon_state = "blender"
	/// What reagent container do we have currently in this baby?
	var/obj/item/reagent_containers/loaded_reagent_container
	/// What is the path of the reagent container we want to start off with? If null/false, don't use one.
	var/starting_container = /obj/item/reagent_containers/cup/beaker/large

/obj/item/portable_blender/Initialize(mapload)
	. = ..()
	if(ispath(starting_container))
		loaded_reagent_container = new starting_container(src)

	update_appearance(UPDATE_OVERLAYS)

	// in case we are spawned inside of a feeding tube.
	var/obj/machinery/iv_drip/feeding_tube/our_tube = loc
	if(istype(our_tube))
		our_tube.insert_blender(src)

/obj/item/portable_blender/Destroy()
	if(loaded_reagent_container)
		loaded_reagent_container.forceMove(get_turf(src))
		loaded_reagent_container = FALSE

	return ..()

/obj/item/portable_blender/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(istype(held_item, /obj/item/food))
		context[SCREENTIP_CONTEXT_LMB] = "Insert Food"

	if(istype(held_item, /obj/item/reagent_containers) && !loaded_reagent_container)
		context[SCREENTIP_CONTEXT_LMB] = "Insert Container"

	if(loaded_reagent_container && !held_item)
		context[SCREENTIP_CONTEXT_LMB] = "Remove Container"

	return CONTEXTUAL_SCREENTIP_SET


/obj/item/portable_blender/update_overlays()
	. = ..()
	if(!QDELETED(loaded_reagent_container))
		. += "[base_icon_state]-beaker"

/// Insert food into the blender, return FALSE if the food is unable to be processed for whatever reason.
/obj/item/portable_blender/proc/insert_food(obj/item/food/inserted_food, mob/living/user, ignore_distance = FALSE)
	if(!loaded_reagent_container)
		to_chat(user, span_warning("You aren't able to blend without a container."))
		return FALSE

	if(loaded_reagent_container.reagents.total_volume == loaded_reagent_container.reagents.maximum_volume)
		to_chat(user, span_warning("[loaded_reagent_container] is full!"))
		return FALSE

	var/datum/reagents/food_reagents = inserted_food?.reagents

	// I AM VERY HUNGRY.
	if(!istype(inserted_food) || !istype(food_reagents) || !food_reagents.total_volume)
		to_chat(user, span_warning("[inserted_food] seems to lack anything that could be blended."))
		return FALSE // NO, I DON'T WANT THAT!

	var/grind_time = max((food_reagents.total_volume * 0.25), 2)

	playsound(src, 'sound/machines/blender.ogg', 50, TRUE)
	Shake(pixelshiftx = 1, pixelshifty = 0, duration = grind_time)
	if(!ignore_distance && !do_after(user, grind_time))
		to_chat(user, span_warning("Blending interrupted!"))
		return FALSE

	if(!food_reagents.trans_to(loaded_reagent_container, food_reagents.total_volume))
		return FALSE

	balloon_alert(user, "Blending complete!")
	playsound(src.loc, 'sound/machines/ping.ogg', 50, FALSE)
	qdel(inserted_food)
	return TRUE


/obj/item/portable_blender/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	var/obj/item/reagent_containers/new_container = attacking_item
	if(istype(new_container) && !loaded_reagent_container)
		if(user.transferItemToLoc(new_container, src))
			balloon_alert(user, "Container inserted!")
			loaded_reagent_container = new_container
			update_appearance(UPDATE_OVERLAYS)

		return

	var/obj/item/food/food_item = attacking_item
	if(istype(food_item))
		insert_food(attacking_item, user)
		return

	return ..()

/obj/item/portable_blender/attack_hand(mob/user, list/modifiers)
	if((user.get_inactive_held_item() != src) || !loaded_reagent_container || !in_range(user, src))
		return ..()

	user.put_in_hands(loaded_reagent_container)
	loaded_reagent_container = null
	update_appearance(UPDATE_OVERLAYS)
	balloon_alert(user, "Container removed!")

