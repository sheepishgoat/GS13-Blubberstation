/obj/structure/mineral_door/calorite //GS13
	name = "calorite door"
	icon = 'modular_gs/icons/obj/structure/doors.dmi'
	icon_state = "calorite"
	sheetType = /obj/item/stack/sheet/mineral/calorite
	sheetAmount = 5 //how much it takes to construct us.
	max_integrity = 200
	light_range = 1
	// Sets it open by default
	density = FALSE
	door_opened = TRUE

// If you ever want to make any door like this, just simply add the component like this :3
/obj/structure/mineral_door/calorite/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/fattening_door)

	update_icon() // Updates the sprite when spawned in cause it's closed by default.


/obj/structure/mineral_door/chocolate //kinda placeholderish
	name = "faux chocolate door"
	icon = 'modular_gs/icons/obj/structure/doors.dmi'
	icon_state = "chocolate"
	sheetType = /obj/item/stack/sheet/mineral/sandstone
	max_integrity = 200
