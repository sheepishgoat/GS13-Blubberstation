#define INCENSE_TEMP (T20C + 20)
#define WOOD_FUEL 100
#define PAPER_FUEL 5
#define MAX_FUEL 3000

/datum/supply_pack/goody/fat_incense
	name = "Bloat censer"
	desc = "A recreational bloat censer. Put some wood or paper in, light it up and breathe deep. GATO is not responsible for being yelled at by Atmospheric Technicians."
	cost = 500
	contains = list(/obj/item/fat_incense)

/obj/item/fat_incense
	name = "bloat censer"
	desc = "A vessel for incense. Add some wood and light it up to make it release a relaxing cloud."
	icon = 'modular_gs/icons/obj/incense.dmi'
	icon_state = "incense"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	var/lipoifium_release = 1
	var/fuel
	var/lit = FALSE

/obj/item/fat_incense/proc/change_state()
	if(lit == FALSE)
		lit = TRUE
		START_PROCESSING(SSobj, src)
	else
		lit = FALSE
		STOP_PROCESSING(SSobj, src)
		update_steam_particles()
	update_icon()
	return


/obj/item/fat_incense/examine(mob/user)
	. = ..()
	. += span_notice("There's [fuel ? "[fuel] fuel" : "no fuel"] in it.")

/obj/item/fat_incense/Destroy()
	if(lit)
		STOP_PROCESSING(SSobj, src)
	QDEL_NULL(particles)
	return ..()

/obj/item/fat_incense/update_overlays()
	. = ..()
	if(lit)
		. += "smoke"

/obj/item/fat_incense/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(lit == TRUE && istype(tool, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/reagent_container = tool
		if(!reagent_container.is_open_container())
			return ITEM_INTERACT_BLOCKING
		if(reagent_container.reagents.has_reagent(/datum/reagent/water))
			reagent_container.reagents.remove_reagent(/datum/reagent/water, 5)
			user.visible_message(span_notice("[user] puts out the [src]."), span_notice("You put out the [src]."))
			change_state()
			return ITEM_INTERACT_SUCCESS
		else
			balloon_alert(user, "no water!")
			return ITEM_INTERACT_BLOCKING

	else if(istype(tool, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/wood = tool
		if(fuel > MAX_FUEL)
			balloon_alert(user, "it's full!")
			return ITEM_INTERACT_BLOCKING
		fuel += WOOD_FUEL * wood.amount
		wood.use(wood.amount)
		user.visible_message(span_notice("[user] tosses some \
			wood into [src]."), span_notice("You add \
			some fuel to [src]."))
		return ITEM_INTERACT_SUCCESS

	else if(istype(tool, /obj/item/paper_bin))
		var/obj/item/paper_bin/paper_bin = tool
		user.visible_message(span_notice("[user] throws [tool] into \
			[src]."), span_notice("You add [tool] to [src].\
			"))
		fuel += PAPER_FUEL * paper_bin.total_paper
		qdel(paper_bin)
		return ITEM_INTERACT_SUCCESS

	else if(istype(tool, /obj/item/paper))
		user.visible_message(span_notice("[user] throws [tool] into \
			[src]."), span_notice("You throw [tool] into [src].\
			"))
		fuel += PAPER_FUEL
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

	if(lit == FALSE && fuel > 0 && tool.ignition_effect(src, user) != "")
		user.visible_message(span_notice("[user] lights up the [src]."), span_notice("You light up the [src]."))
		change_state()
		return ITEM_INTERACT_SUCCESS

/obj/item/fat_incense/process()
	update_steam_particles()
	var/turf/open/pos = get_turf(src)
	if(istype(pos) && pos.air.return_pressure() < 1.5*ONE_ATMOSPHERE)
		pos.atmos_spawn_air("lipoifium=[lipoifium_release];TEMP=[INCENSE_TEMP]")
	fuel--
	if(fuel <= 0)
		lit = FALSE
		update_steam_particles()
		STOP_PROCESSING(SSobj, src)
		update_icon()

/obj/item/fat_incense/proc/update_steam_particles()
	if(particles)
		if(lit)
			return
		QDEL_NULL(particles)
		return

	if(lit)
		particles = new /particles/smoke/steam/mild
		particles.position = list(0, 6, 0)
