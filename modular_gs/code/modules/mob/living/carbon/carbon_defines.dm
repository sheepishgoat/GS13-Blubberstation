/mob/living/carbon
	//Due to the changes needed to create the system to hide fatness, here's some notes:
	// -If you are making a mob simply gain or lose weight, use adjust_fatness. Try to not touch the variables directly unless you know 'em well
	// -fatness is the value a mob is being displayed and calculated as by most things. Changes to fatness are not permanent
	// -fatness_real is the value a mob is actually at, even if it's being hidden. For permanent changes, use this one
	// -fatness_perma is the fatness that cannot be hidden/removen via ordinary means. If you wanna fuck em up, use this
	// PLEASE NOTE - If you add more fatness variables and you want them to show on scales, please add them to `modular_gs\code\modules\mob\living\carbon\weight_helpers.dm`!

	///What level of fatness is the parent mob currently at?
	var/fatness = 0
	///The actual value a mob is at. Is equal to fatness if fat_hider is FALSE.
	var/fatness_real = 0
	///Permanent fatness, which sticks around between rounds
	var/fatness_perma = 0
	/// What is the maximum amount of weight we can put on?
	var/max_weight
	
	///The list of items/effects that are being added/subtracted from our real fatness
	var/fat_hiders = list()

	///At what rate does the parent mob gain weight? 1 = 100%
	var/weight_gain_rate = 1
	///At what rate does the parent mob lose weight? 1 = 100%
	var/weight_loss_rate = 1
	/// modifier for weight gain rate. Don't modify this directly, instead use the set and add_weight_gain_modifier procs
	var/list/weight_gain_modifiers = list()
	/// modifier for weight loss rate. Don't modify this directly, instead use the set and add_weight_loss_modifier procs
	var/list/weight_loss_modifiers = list()
	/// whether we flip the sign on the final WG rate. This will make any fattening action make you lose weight instead
	var/flip_gain_rate = FALSE
	/// whether we flip the sign on the final WL rate. This will make any slimming action make you gain weight
	var/flip_loss_rate = FALSE

	var/fullness = 20
	/// When was the last time they emoted to reduce their fullness
	var/fullness_reduction_timer = 0
	/// by how much we reduce the mob fullness compared to what it actually is
	var/fullness_adjustment = 0

	/// How many humanoid mobs have been digested by this mob?
	var/carbons_digested = 0

	/// How many times have we bursted?
	var/times_blueberry_bursted = 0
	var/datum/looping_sound/blueberry_inflation/blueberry_inflate_loop
