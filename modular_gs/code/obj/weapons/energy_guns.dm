// #region fatorays

///The base fatoray
/obj/item/gun/energy/fatoray
	name = "Fatoray"
	desc = "An energy gun that fattens up anyone it hits."
	icon = 'modular_gs/icons/obj/weapons/fatoray.dmi'
	lefthand_file = 'modular_gs/icons/mob/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_gs/icons/mob/inhands/guns_righthand.dmi'
	icon_state = "fatoray"
	inhand_icon_state = "fatoray"
	pin = /obj/item/firing_pin
	fire_sound = 'sound/items/weapons/plasma_cutter.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/fattening)

/obj/item/gun/energy/fatoray/weak
	name = "Basic Fatoray"
	desc = "An energy gun that fattens up anyone it hits. This version is considerably weaker than its original counterpart, the technology behind it seemingly still not perfected."
	icon_state = "fatoray_weak"
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/weak)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.3,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT * 0.5
		)

/// cannon variant, strong but can be charged
/obj/item/gun/energy/fatoray/cannon
	name = "Fatoray Cannon"
	desc = "An energy gun that fattens up anyone it hits. This version functions as a glass cannon of some sorts."
	icon_state = "fatoray_cannon"
	recoil = 3
	can_charge = TRUE
	slowdown = 1
	weapon_weight = WEAPON_HEAVY
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/cannon)

///Single shot glass cannon fatoray
/obj/item/gun/energy/fatoray/cannon/weak
	name = "Basic Fatoray Cannon"
	icon_state = "fatoray_cannon_weak"
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/cannon/weak)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT
		)

/obj/item/gun/energy/fatoray/stunning	// it's STUNNINGLY effective
	name = "\improper GATO EG-1 Salamander"
	desc = "An advanced energy gun that both stuns and fattens up its target."
	icon_state = "immobilizer"
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/stun)

/obj/item/gun/energy/fatoray/stunning/antag
	name = "Syndicate upgraded EG-1 Salamander"
	desc = "A CyberSun improved version of the GATO EG-1 Salamander. Its shots both stun and fatten up the target. It has a more powerful powercell installed compared to the original, providing greater ammo capacity."
	cell_type = /obj/item/stock_parts/power_store/cell/upgraded

// #endregion

/obj/item/gun/energy/e_gun/fattening
	name = "\improper GATO EG-2 Matador"
	desc = "A basic hybrid energy gun with two settings: fatten and disable."
	icon = 'modular_gs/icons/obj/weapons/fatoray.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/cheap, /obj/item/ammo_casing/energy/disabler)
	lefthand_file = 'modular_gs/icons/mob/inhands/guns_lefthand.dmi'
	righthand_file = 'modular_gs/icons/mob/inhands/guns_righthand.dmi'

/obj/item/gun/energy/e_gun/fattening/antag
	name = "Syndicate upgraded EG-2 Matador"
	desc = "A CyberSun improved version of the GATO EG-2 Matador. It has two settings: fatten and disable. The CyberSun upgrades include fitting a larger powercell inside to provide greater ammo capacity."
	cell_type = /obj/item/stock_parts/power_store/cell/upgraded

// #region AL-T-Rays

/obj/item/gun/energy/laser/alter_ray
	abstract_type = /obj/item/gun/energy/laser/alter_ray
	name = "alter-ray"
	icon = 'modular_gs/icons/obj/weapons/alter_ray.dmi'
	icon_state = "alter_ray"
	desc = "This weapon is capable of altering one's body capabilities."
	w_class = WEIGHT_CLASS_NORMAL
	selfcharge = TRUE
	charge_delay = 5
	ammo_x_offset = 2
	clumsy_check = 1
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.4,
		/datum/material/calorite = SHEET_MATERIAL_AMOUNT * 1.3
		)

/// variant that adjusts WG/WL rate
/obj/item/gun/energy/laser/alter_ray/gainrate
	name = "AL-T-Ray: Metabolism"
	desc = "This weapon is capable of altering one's body capabilities. This model appears to be capable of altering one's weight gain and loss rate by 10%."
	ammo_type = list(
		/obj/item/ammo_casing/energy/laser/alter_ray/gainrate_decrease,
		/obj/item/ammo_casing/energy/laser/alter_ray/gainrate_increase,
		/obj/item/ammo_casing/energy/laser/alter_ray/lossrate_decrease,
		/obj/item/ammo_casing/energy/laser/alter_ray/lossrate_increase)

/// AL-T-Ray for making someone gain from weight loss
/obj/item/gun/energy/laser/alter_ray/noloss
	name = "AL-T-Ray: Reverser"
	desc = "This weapon is capable of altering one's body capabilities. This one reverse's ones body functions, to make it so weight loss results in weight gain. Getting hit again will return the target's metabolism to normal, until hit again."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/alter_ray/lossrate_reverse)

// #endregion
