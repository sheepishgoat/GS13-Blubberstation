/obj/vehicle/ridden/grocery_cart //ported from Hippiestation (by Jujumatic)
	name = "grocery cart"
	desc = "A cart you can use to hold groceries, or ride in."
	icon = 'modular_gs/icons/obj/vehicles.dmi'
	icon_state = "grocery_cart"
	layer = OBJ_LAYER
	max_integrity = 100
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 30)	//grocery_carts aren't super tough yo
	legs_required = 0	//You'll probably be using this if you don't have legs
	canmove = TRUE
	density = FALSE		//Thought I couldn't fix this one easily, phew
	// Run speed delay is multiplied with this for vehicle move delay.
	var/delay_multiplier = 6.7

/obj/vehicle/ridden/grocery_cart/Initialize()
	. = ..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 3
	D.set_vehicle_dir_layer(SOUTH, OBJ_LAYER)
	D.set_vehicle_dir_layer(NORTH, ABOVE_MOB_LAYER)
	D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
	D.set_vehicle_dir_layer(WEST, OBJ_LAYER)

/obj/vehicle/ridden/grocery_cart/ComponentInitialize()	//Since it's technically a chair I want it to have chair properties
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src,PROC_REF(can_user_rotate),CALLBACK(src),PROC_REF(can_be_rotated),null))

/obj/vehicle/ridden/grocery_cart/obj_destruction(damage_flag)
	new /obj/item/stack/rods(drop_location(), 1)
	new /obj/item/stack/sheet/metal(drop_location(), 1)
	..()

/obj/vehicle/ridden/grocery_cart/Destroy()
	if(has_buckled_mobs())
		var/mob/living/carbon/H = buckled_mobs[1]
		unbuckle_mob(H)
	return ..()

/obj/vehicle/ridden/grocery_cart/driver_move(mob/living/user, direction)
	if(istype(user))
		if(canmove && (user.get_num_arms() < arms_required))
			to_chat(user, "<span class='warning'>You don't have enough arms to operate the wheels!</span>")
			canmove = FALSE
			addtimer(VARSET_CALLBACK(src, canmove, TRUE), 20)
			return FALSE
		set_move_delay(user)
	return ..()

/obj/vehicle/ridden/grocery_cart/proc/set_move_delay(mob/living/user)
	var/datum/component/riding/D = GetComponent(/datum/component/riding)
	//1.5 (movespeed as of this change) multiplied by 6.7 gets ABOUT 10 (rounded), the old constant for the grocery_cart that gets divided by how many arms they have
	//if that made no sense this simply makes the grocery_cart speed change along with movement speed delay
	D.vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) * delay_multiplier) / min(user.get_num_arms(), 2)

/obj/vehicle/ridden/grocery_cart/Moved()
	. = ..()
	cut_overlays()
	playsound(src, 'sound/effects/roll.ogg', 75, TRUE)
	if(has_buckled_mobs())
		handle_rotation_overlayed()


/obj/vehicle/ridden/grocery_cart/post_buckle_mob(mob/living/user)
	. = ..()
	handle_rotation_overlayed()

/obj/vehicle/ridden/grocery_cart/post_unbuckle_mob()
	. = ..()
	cut_overlays()

/obj/vehicle/ridden/grocery_cart/setDir(newdir)
	..()
	handle_rotation(newdir)

/obj/vehicle/ridden/grocery_cart/wrench_act(mob/living/user, obj/item/I)	//Attackby should stop it attacking the grocery_cart after moving away during decon
	..()
	to_chat(user, "<span class='notice'>You begin to detach the wheels...</span>")
	if(I.use_tool(src, user, 40, volume=50))
		to_chat(user, "<span class='notice'>You detach the wheels and deconstruct the chair.</span>")
		new /obj/item/stack/rods(drop_location(), 6)
		new /obj/item/stack/sheet/metal(drop_location(), 4)
		qdel(src)
	return TRUE

/obj/vehicle/ridden/grocery_cart/proc/handle_rotation(direction)
	if(has_buckled_mobs())
		handle_rotation_overlayed()
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			buckled_mob.setDir(direction)

/obj/vehicle/ridden/grocery_cart/proc/handle_rotation_overlayed()
	cut_overlays()
	var/image/V = image(icon = icon, icon_state = "grocery_cart_overlay", layer = FLY_LAYER, dir = src.dir)
	add_overlay(V)



/obj/vehicle/ridden/grocery_cart/proc/can_be_rotated(mob/living/user)
	return TRUE

/obj/vehicle/ridden/grocery_cart/proc/can_user_rotate(mob/living/user)
	var/mob/living/L = user
	if(istype(L))
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			return FALSE
	if(isobserver(user) && CONFIG_GET(flag/ghost_interaction))
		return TRUE
	return FALSE

/obj/vehicle/ridden/grocery_cart/the_whip/driver_move(mob/living/user, direction)
	if(istype(user))
		var/datum/component/riding/D = GetComponent(/datum/component/riding)
		D.vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) * 6.7) / user.get_num_arms()
	return ..()
