/datum/supply_pack/vending/mealdor
	name = "Meal Vendor Supply Crate"
	desc = "Suprising one to order. If you need a refill for the meal vendor, someone's immobile somewhere. And since you managed to make it to cargo... Well it's not our job to say no!"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/vending_refill/mealdor)
	crate_name = "meal vendor supply crate"

/datum/supply_pack/organic/feeding_tube
	name = "Feeding Tube Crate"
	desc = "A machine commonly found in automated barns, used for feeding livestock... though it can be used for just about anything. Or anyone. Comes with an inbuilt state-of-the-art grinder-beaker."
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(
		/obj/machinery/iv_drip/feeding_tube,
	)
	crate_name = "feeding tube"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/greaseburger_combo
	name = "Greaseburger Combo Crate"
	desc = "GATO is not responsible for any clogged arteries that may result from the consumption of this combo meal. Now comes with a big bottle of soda, so there's something else in your throat besides just grease!"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/food/burger/greaseburger,
		/obj/item/food/burger/greaseburger,
		/obj/item/food/burger/greaseburger,
		/obj/item/reagent_containers/cup/bigbottle/cola,
	)
	crate_name = "greaseburger combo"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/materials/material_starter
	name = "Material Starter Crate"
	desc = "A set of basic materials required to 'jumpstart' station set-up. Bluespace crystals and calorite not included."
	cost = (CARGO_CRATE_VALUE * 2) + 7050
	contains = list(
		/obj/item/stack/sheet/iron/twenty,
		/obj/item/stack/sheet/glass/fifty,
		/obj/item/stack/sheet/plasteel/ten,
		/obj/item/stack/sheet/mineral/titanium/five,
		/obj/item/stack/sheet/mineral/silver/five,
		/obj/item/stack/sheet/mineral/gold/five,
		/obj/item/stack/sheet/mineral/uranium/five,
		/obj/item/stack/sheet/mineral/diamond,

	)
	crate_name = "starter materials"


/*

/datum/supply_pack/misc/livestock
	name = "Livestock Implant"
	desc = "A cruel but effective method of keeping prisoners in line - turn them into docile cattle!"
	cost = 8000
	contains = list(/obj/item/implantcase/docile/livestock,
					/obj/item/implanter)
	crate_name = "livestock implant crate"
	contraband = TRUE


/datum/supply_pack/vending/wardrobes/clothing //existing game item not in cargo for some reason
	name = "ClothesMate Supply Crate"
	desc = "ClothesMate missing your favorite outfit? Solve that issue today with this autodrobe refill."
	cost = 1500
	contains = list(/obj/item/vending_refill/clothing)
	crate_name = "clothesmate supply crate"

/datum/supply_pack/misc/sop_manuals
	name = "Standard Operating Procedure Book Pack"
	desc = "A pack of all SOP books released by GATO! Contains 9 releases."
	cost = 1000
	contains = list(/obj/item/book/manual/science_SOP,
					/obj/item/book/manual/service_SOP,
					/obj/item/book/manual/supply_SOP,
					/obj/item/book/manual/engi_SOP,
					/obj/item/book/manual/med_SOP,
					/obj/item/book/manual/sec_SOP,
					/obj/item/book/manual/command_SOP,
					/obj/item/book/manual/prisoner_SOP,
					/obj/item/book/manual/greytide_SOP)
	crate_name = "sop books crate"

*/
/datum/supply_pack/goody/fat_incense
	name = "Bloat censer"
	desc = "A recreational bloat censer. Put some wood or paper in, light it up and breathe deep. GATO is not responsible for being yelled at by Atmospheric Technicians."
	cost = 500
	contains = list(/obj/item/fat_incense)

/datum/supply_pack/goody/holo_wheelchair
	name = "Hardlight Wheelchair Emitter"
	desc = "Popular in GS13, this emitter is able to project a hardlight wheelchair for an user to sit in."
	cost = 150
	contains = list(/obj/item/holosign_creator/hardlight_wheelchair)

/datum/supply_pack/goody/caloritepen
	name = "Novelty Calorite Pen"
	desc = "A novelty pen with the tip made out of calorite, made to celebrate the success of Nutri-Tech! GATO is not liable for any mishandlings of this novelty item."
	cost = 1000
	contains = list(/obj/item/pen/calorite)

/datum/supply_pack/goody/adipoluri
	name = "Soft Massage Oil"
	desc = "A medical gel applicator bottle, containing adipoluri substance meant to be rubbed on fat tissure to mend bruises and burns. When the gel is applied, the person may be subject to small amounts of weight gain when massaged."
	cost = 200
	contains = list(/obj/item/reagent_containers/medigel/adipoluri)
