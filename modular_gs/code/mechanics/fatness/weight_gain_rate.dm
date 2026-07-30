/// returns the total value of all WG modifiers
/mob/living/carbon/proc/get_weight_gain_modifiers()
	var/total_modifier = 0
	for (var/key in weight_gain_modifiers)
		total_modifier += clamp(weight_gain_modifiers[key], WEIGHT_RATE_MODIFIER_MIN_VALUE, WEIGHT_RATE_MODIFIER_MAX_VALUE)

	return total_modifier

/// returns the total value of all WL modifiers
/mob/living/carbon/proc/get_weight_loss_modifiers()
	var/total_modifier = 0
	for (var/key in weight_loss_modifiers)
		total_modifier += clamp(weight_loss_modifiers[key], WEIGHT_RATE_MODIFIER_MIN_VALUE, WEIGHT_RATE_MODIFIER_MAX_VALUE)

	return total_modifier

/**
 * Adds a weight gain modifier to the modifier list
 *
 * If the modifier doesn't exist yet, adds it as an entry and sets it's value. If it does exist, adds value to it.
 *
 * Arguments:
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/add_weight_gain_modifier(source, value)
	if (weight_gain_modifiers[source])
		weight_gain_modifiers[source] += value
		return

	set_weight_gain_modifier(source, value)

/**
 * Sets a weight gain modifier in the modifier list
 *
 * Will always set the modifier to the set value, regardless of the previously stored value
 * 
 * Arguments:
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/set_weight_gain_modifier(source, value)
	weight_gain_modifiers[source] = value

/**
 * Adds a weight loss modifier to the modifier list
 *
 * If the modifier doesn't exist yet, adds it as an entry and sets it's value. If it does exist, adds value to it.
 *
 * Arguments:
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/add_weight_loss_modifier(source, value)
	if (weight_loss_modifiers[source])
		weight_loss_modifiers[source] += value
		return

	set_weight_loss_modifier(source, value)

/**
 * Sets a weight loss modifier in the modifier list
 *
 * Will always set the modifier to the set value, regardless of the previously stored value
 * 
 * Arguments:
 * * source - value containing the identifier of the source, IDEALLY a string
 * * value - value to add to the modifier
 */
/mob/living/carbon/proc/set_weight_loss_modifier(source, value)
	weight_loss_modifiers[source] = value

/// returns the current value of given weight gain modifier. If such a modifier doesn't exits, returns 0
/mob/living/carbon/proc/get_weight_gain_modifier(source)
	if (weight_gain_modifiers[source])
		return weight_gain_modifiers[source]

	return 0

/// returns the current value of given weight loss modifier. If such a modifier doesn't exits, returns 0
/mob/living/carbon/proc/get_weight_loss_modifier(source)
	if (weight_loss_modifiers[source])
		return weight_loss_modifiers[source]

	return 0

/// completely removes a weight gain modifier from the list. Does nothing if the modifier does not exist
/mob/living/carbon/proc/remove_weight_gain_modifier(source)
	if (!weight_gain_modifiers[source])
		return

	weight_gain_modifiers.Remove(source)

/// completely removes a weight loss modifier from the list. Does nothing if the modifier does not exist
/mob/living/carbon/proc/remove_weight_loss_modifier(source)
	if (!weight_loss_modifiers[source])
		return

	weight_loss_modifiers.Remove(source)

/// removes all weight gain modifiers
/mob/living/carbon/proc/clear_weight_gain_modifiers()
	weight_gain_modifiers.Cut()

/// removes all weight loss modifiers
/mob/living/carbon/proc/clear_weight_loss_modifiers()
	weight_loss_modifiers.Cut()

/// returns the final weight gain rate of a carbon, taking into account all modifiers, flips, traits etc
/mob/living/carbon/proc/get_weight_gain_rate()
	var/local_gain_rate = weight_gain_rate

	if (HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		local_gain_rate = max(UNIVERSAL_GAINER_MINIMUM_WG_RATE, local_gain_rate)

	local_gain_rate += get_weight_gain_modifiers()

	if (flip_gain_rate)
		local_gain_rate = -local_gain_rate

	return local_gain_rate

/// returns the final weight loss rate of a carbon, taking into account all modifiers, flips, traits etc
/mob/living/carbon/proc/get_weight_loss_rate()
	var/local_loss_rate = weight_loss_rate

	if (HAS_TRAIT(src, TRAIT_UNIVERSAL_GAINER))
		local_loss_rate = min(UNIVERSAL_GAINER_MAXIMUM_WL_RATE, local_loss_rate)

	local_loss_rate += get_weight_loss_modifiers()

	if (flip_loss_rate)
		local_loss_rate = -local_loss_rate

	return local_loss_rate
