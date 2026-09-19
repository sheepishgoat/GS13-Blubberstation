// #region fattening

/obj/item/ammo_casing/energy/fattening
	name = "fattening weapon lens"
	select_name = "fatten"
	projectile_type = /obj/projectile/beam/fattening
	harmful = FALSE

/obj/projectile/beam/fattening/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if (. == BULLET_ACT_BLOCK)
		return .

	if (iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		if (carbon_target.micro_calorite_poisoning >= 1)
			if (carbon_target.adjust_calorite_poisoning(-0.01 * fat_added))
				carbon_target.adjust_perma(1 * fat_added, FATTENING_TYPE_WEAPON, TRUE)

	return .

/obj/item/ammo_casing/energy/fattening/weak
	name = "budget fattening weapon lens"
	select_name = "fatten"
	projectile_type = /obj/projectile/beam/fattening/weak

/obj/item/ammo_casing/energy/fattening/cheap
	name = "efficient fattening weapon lens"
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE)

/obj/item/ammo_casing/energy/fattening/stun
	name = "calorite-disabler weapon lens"
	select_name = "disable-fatten"
	projectile_type = /obj/projectile/beam/fattening/stun

/obj/item/ammo_casing/energy/fattening/cannon
	name = "one-shot fattening weapon lens"
	e_cost = 1000
	projectile_type = /obj/projectile/beam/fattening/cannon

/obj/item/ammo_casing/energy/fattening/cannon/weak
	e_cost = 1600
	projectile_type = /obj/projectile/beam/fattening/cannon/weak

// #endregion
// #region AL-T-Rays

/obj/item/ammo_casing/energy/laser/alter_ray
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/alter_ray/gainrate_increase
	projectile_type = /obj/projectile/beam/alter_ray/gain_rate/increase
	select_name = "Weight Gain Increase"

/obj/item/ammo_casing/energy/laser/alter_ray/gainrate_decrease
	projectile_type = /obj/projectile/beam/alter_ray/gain_rate/decrease
	select_name = "Weight Gain Decrease"

/obj/item/ammo_casing/energy/laser/alter_ray/lossrate_increase
	projectile_type = /obj/projectile/beam/alter_ray/loss_rate/increase
	select_name = "Weight Loss Increase"

/obj/item/ammo_casing/energy/laser/alter_ray/lossrate_decrease
	projectile_type = /obj/projectile/beam/alter_ray/loss_rate/decrease
	select_name = "Weight Loss Decrease"

/obj/item/ammo_casing/energy/laser/alter_ray/lossrate_reverse
	projectile_type = /obj/projectile/beam/alter_ray/lossrate_reverse
	select_name = "Weight Loss Reverse"

// #endregion
