/datum/uplink_category/adipowarfare
	name = "Adipo-Warfare"
	weight = -5

/datum/uplink_item/adipowarfare
	category = /datum/uplink_category/adipowarfare
	surplus = 5

/datum/uplink_item/adipowarfare/lipoifiergrenade
	name = "Lipoifier Smoke Grenade"
	desc = "A smoke grenade with the fattening lipoifier chemical mixed in. Great for slowing down your enemies and get-aways."
	item = /obj/item/grenade/chem_grenade/lipoifier
	cost = 2
	cant_discount = TRUE

/datum/uplink_item/adipowarfare/galbanicgrenade
	name = "Galbanic Smoke Grenade"
	desc = "A smoke grenade with the highly fattening galbanic chemical mixed in. Great for slowing down your enemies and get-aways."
	item = /obj/item/grenade/chem_grenade/galbanic
	cost = 3
	cant_discount = TRUE

/datum/uplink_item/adipowarfare/fattonatorgrenade
	name = "Fattonator Smoke Grenade"
	desc = "A smoke grenade with a mix of lipoifier, galbanic and micro-calorite added in. Great for slowing down your enemies and get-aways."
	item = /obj/item/grenade/chem_grenade/fatmix
	cost = 4
	cant_discount = FALSE

//weapons
/datum/uplink_item/adipowarfare/fatoray
	name = "Fatoray Pistol"
	desc = "A pistol with calorite laser lens, capable of firing fattening but harmless shots."
	item = /obj/item/gun/energy/fatoray
	cost = 2

/datum/uplink_item/adipowarfare/fatoray_cannon
	name = "Fatoray Cannon"
	desc = "A larger, heavier variant of the Fatoray. It fires very fattening but harmless projectiles, but has about 10 shots of charge."
	item = /obj/item/gun/energy/fatoray/cannon
	cost = 4
	cant_discount = FALSE

/datum/uplink_item/adipowarfare/fat_whip
	name = "Calorite Whip"
	desc = "A harmless whip that fattens the target with each hit. Great for disarming people while fattening them at the same time."
	item = /obj/item/melee/curator_whip/fattening
	cost = 2

/datum/uplink_item/adipowarfare/permafat_whip
	name = "Galbanic Whip"
	desc = "A harmless whip that perma-fattens the target with each hit. Great for disarming people while perma-fattening them at the same time."
	item = /obj/item/melee/curator_whip/permafattening
	cost = 4
	cant_discount = FALSE

/datum/uplink_item/adipowarfare/caloritepen
	name = "Galbanic-Infused Calorite Pen"
	desc = "A novelty pen with a calorite tip, infused with galbanic. Does a little bit of perma-fattening and calorite poisoning on stab."
	item = /obj/item/pen/calorite/syndicate
	cost = 1
	cant_discount = TRUE

/datum/uplink_item/adipowarfare/alter_ray_reverser
	name = "Alter-Ray Reverser"
	desc = "A lasergun that's capable of reversing the subject's metabolism, making them unable to lose weight."
	item = /obj/item/gun/energy/laser/alter_ray/noloss
	cost = 1
	cant_discount = TRUE

//chems
/datum/uplink_item/adipowarfare/lipoifier_beaker
	name = "Beaker of Lipoifier"
	desc = "A beaker full of Lipoifier chemical. Ingestion results in rapid weight gain."
	item = /obj/item/reagent_containers/cup/beaker/lipoifier
	cost = 1
	cant_discount = TRUE

/datum/uplink_item/adipowarfare/galbanic_beaker
	name = "Beaker of Galbanic Compound"
	desc = "A beaker full of Galbanic Compound chemical. Ingestion results in rapid weight gain, with a small fraction of it being long-term fat."
	item = /obj/item/reagent_containers/cup/beaker/galbanic
	cost = 2
	cant_discount = FALSE

/datum/uplink_item/adipowarfare/micro_calorite_beaker
	name = "Beaker of Micro-Calorite"
	desc = "A beaker full of Micro-Calorite chemical. Ingestion results in changes to a person's metabolism and increases micro-calorite poisoning."
	item = /obj/item/reagent_containers/cup/beaker/micro_calorite
	cost = 2
	cant_discount = FALSE

/datum/uplink_item/adipowarfare/micro_calorite_beaker
	name = "Memento Calori"
	desc = "A necklace that hides all of your fatness, long-term and short-term. Taking it off results in a lot of weight gain, however."
	item = /obj/item/clothing/neck/necklace/memento_mori/calori/sprinkled
	cost = 2
	cant_discount = FALSE

//adding in a category for OPFOR items here as well
//these items can be found in OTHER category in OPFOR menu

/datum/opposing_force_equipment/antagonist_powers/lipoifiergrenade
	name = "Lipoifier Smoke Grenade"
	item_type = /obj/item/grenade/chem_grenade/lipoifier
	description = "A single smoke grenade with lipoifier mixed in. Good for getaways and sabotaging the enemy's waistline."
	admin_note = "Useful for kink antags. Generally harmless. Only fattens people."

/datum/opposing_force_equipment/antagonist_powers/galbanicgrenade
	name = "Galbanic Smoke Grenade"
	item_type = /obj/item/grenade/chem_grenade/galbanic
	description = "A single smoke grenade with galbanic compound mixed in. Good for getaways and sabotaging the enemy's waistline."
	admin_note = "Useful for kink antags. Generally harmless. Fattens people. Galbanic has permafattening and OD properties"

/datum/opposing_force_equipment/antagonist_powers/galbanicgrenade
	name = "Fattonator Smoke Grenade"
	item_type = /obj/item/grenade/chem_grenade/fatmix
	description = "A single smoke grenade with a mix of galbanic, lipoifier and micro-calorite. Good for getaways and sabotaging the enemy's waistline."
	admin_note = "Useful for kink antags. Generally harmless. Fattens people. Galbanic has permafattening and OD properties"

/datum/opposing_force_equipment/antagonist_powers/fatoray
	name = "Fatoray Pistol"
	item_type = /obj/item/gun/energy/fatoray
	description = "A laser pistol with calorite fattening lens. Its shots are harmless, but fatten the target."
	admin_note = "Useful for kink antags. Generally harmless. Fattens people."

/datum/opposing_force_equipment/antagonist_powers/fatoray_cannon
	name = "Fatoray Cannon"
	item_type = /obj/item/gun/energy/fatoray/cannon
	description = "A larger variant of the fatoray: a large laser cannon with calorite fattening lens. Its shots are harmless, but fatten the target. This model has about 10 shots, but they fatten up by a lot."
	admin_note = "Useful for kink antags. Generally harmless. Fattens people."

/datum/opposing_force_equipment/antagonist_powers/calorite_whip
	name = "Calorite Whip"
	item_type = /obj/item/melee/curator_whip/fattening
	description = "A calorite-laden whip. Its attacks are harmless but they disarm and fatten targets."
	admin_note = "Useful for kink antags. Generally harmless. Fattens people. Great at disarming."

/datum/opposing_force_equipment/antagonist_powers/galbanic_whip
	name = "Galbanic Whip"
	item_type = /obj/item/melee/curator_whip/permafattening
	description = "A galbanic-infused whip. Its attacks are harmless but they disarm and perma-fatten targets."
	admin_note = "Useful for kink antags. Generally harmless. Perma-fattens people. Great at disarming."

/datum/opposing_force_equipment/antagonist_powers/caloritepen
	name = "Galbanic-infused Calorite Pen"
	item_type = /obj/item/pen/calorite/syndicate
	description = "A novelty pen with a calorite tip, infused with galbanic. Does a little bit of perma-fattening and calorite poisoning on stab."
	admin_note = "Useful for kink antags. No combat capability. Perma-fattens people and adds calorite poisoning."


/datum/opposing_force_equipment/antagonist_powers/lipoifier_beaker
	name = "Beaker of Lipoifier"
	item_type = /obj/item/reagent_containers/cup/beaker/lipoifier
	description = "A beaker full of lipoifier chemical. Fattens upon ingestion."
	admin_note = "Useful for kink antags. Generally harmless. Fattens people."

/datum/opposing_force_equipment/antagonist_powers/galbanic_beaker
	name = "Beaker of Galbanic Compound"
	item_type = /obj/item/reagent_containers/cup/beaker/galbanic
	description = "A beaker full of galbanic compound chemical. Fattens upon ingestion, with small fraction of WG being perma-fat. Has a 50u OD threshold and can be addictive."
	admin_note = "Useful for kink antags. Generally harmless. Fattens and perma-fattens people. Has an OD threshold and can be addictive."

/datum/opposing_force_equipment/antagonist_powers/micro_calorite_beaker
	name = "Beaker of Micro-Calorite"
	item_type = /obj/item/reagent_containers/cup/beaker/micro_calorite
	description = "A beaker full of micro-calorite chemical. Micro-calorite digests slowly, doing -30% to Weight Loss and +30% to Weight Gain in the system. Also slowly increases calorite poisoning, which has its own effects. 100u OD threshold fattens the person."
	admin_note = "Useful for kink antags. Generally harmless. Changes person's metabolism and increases micro-calorite poisoning."

/datum/opposing_force_equipment/antagonist_powers/memento_calori
	name = "Memento Calori"
	item_type = /obj/item/clothing/neck/necklace/memento_mori/calori/sprinkled
	description = "A necklace that hides all of your fatness, long-term and short-term. Taking it off results in a lot of weight gain, however."
	admin_note = "Useful for kink antags. Generally harmless. Useful for kink antags that don't want to gain weight."
