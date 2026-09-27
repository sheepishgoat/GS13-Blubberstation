// #region Fatorays

///The base projectile used by the fatoray
/obj/projectile/beam/fattening
	name = "fat energy"
	icon = 'modular_gs/icons/obj/weapons/fatoray.dmi'
	icon_state = "ray"
	ricochets_max = 50
	ricochet_chance = 80
	damage = 0
	eyeblur = 0
	damage_type = STAMINA
	light_range = 2
	light_color = LIGHT_COLOR_ORANGE
	fat_added = 200

/// variant that actually does stamina damage
/obj/projectile/beam/fattening/stun
	fat_added = 150
	damage = 30

/obj/projectile/beam/fattening/weak
	fat_added = 100

/obj/projectile/beam/fattening/cannon
	icon_state = "cannon_ray"
	fat_added = 800

/obj/projectile/beam/fattening/cannon/weak
	fat_added = 400

// #endregion
// #region AL-T-Rays

/// base al-t-ray projectile
/obj/projectile/beam/alter_ray
	name = "sizeray beam"
	abstract_type = /obj/projectile/beam/alter_ray
	icon_state = "omnilaser"
	hitsound = null
	damage = 0
	eyeblur = 0
	damage_type = STAMINA
	ricochets_max = 50
	ricochet_chance = 80
	light_range = 2
	var/ratechange_amount = 0.1

/// WG rate changing
/obj/projectile/beam/alter_ray/gain_rate/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		gainer.add_weight_gain_modifier("AL-T-Ray", ratechange_amount)
		return TRUE

	return FALSE

/// WL rate changing
/obj/projectile/beam/alter_ray/loss_rate/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		gainer.add_weight_loss_modifier("AL-T-Ray", ratechange_amount)
		return TRUE

	return FALSE

/obj/projectile/beam/alter_ray/gain_rate/decrease
	icon_state="bluelaser"
	light_color = LIGHT_COLOR_DARK_BLUE
	ratechange_amount = -0.1

/obj/projectile/beam/alter_ray/gain_rate/increase
	icon_state="laser"
	light_color = LIGHT_COLOR_INTENSE_RED
	ratechange_amount = 0.1

/obj/projectile/beam/alter_ray/loss_rate/decrease
	icon_state="bluelaser"
	light_color = LIGHT_COLOR_DARK_BLUE
	ratechange_amount = -0.1

/obj/projectile/beam/alter_ray/loss_rate/increase
	icon_state="laser"
	light_color = LIGHT_COLOR_INTENSE_RED
	ratechange_amount = 0.1

/// WL rate reversing
/obj/projectile/beam/alter_ray/lossrate_reverse
	ratechange_amount = 0
	icon_state = "laser"

/obj/projectile/beam/alter_ray/lossrate_reverse/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	var/mob/living/carbon/gainer = target

	if(iscarbon(gainer))
		gainer.flip_loss_rate = !gainer.flip_loss_rate
		return TRUE

// #endregion
