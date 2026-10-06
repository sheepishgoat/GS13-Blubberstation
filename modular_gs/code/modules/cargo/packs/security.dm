/datum/supply_pack/security/large_donut_boxes
	name = "Security sustenance supplies"
	desc = "For the special needs of the security department, this crate makes sure they have the fuel they need to secure justice aboard the station. 10% cheaper than the one available for the masses!"
	cost = CARGO_CRATE_VALUE * 5.4
	contains = list(/obj/item/storage/fancy/large_donut_box = 3)
	crate_name = "security sustenance supplies crate"

/datum/supply_pack/security/armory/salamander
	name = "EG-1 Salamander crate"
	desc = "Contains 3 EG-1 Salamander calorite-energy guns, combining the effects of both \
	fatorays and regular disablers"
	cost = CARGO_CRATE_VALUE * 18
	contains = list(/obj/item/gun/energy/fatoray/stunning = 3)
	crate_name = "calorite energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/centcom

/datum/supply_pack/security/armory/matador
	name = "EG-2 Matador crate"
	desc = "Contains 3 EG-2 Matador calorite-energy guns, capable of firing both stun \
	and calorite infused projectiles."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/gun/energy/e_gun/fattening = 3)
	crate_name = "calorite energy gun crate"
	crate_type = /obj/structure/closet/crate/secure/centcom
