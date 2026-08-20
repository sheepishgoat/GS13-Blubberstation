/**
 * Fattening component
 *
 * Add this component to an object to have it fatten a mob on a certain interaction
 *
 * Created and maintained by Swan on Gain Stations 13 discord, feel free to message me
 * if you have any questions or are interested in expanding/changing this component's
 * functionality
 *
 * When applying for calorite items, in the Initialize proc apply it before you call the ..(), unless you're
 * fine with using the default value for calorite material items
 */
/datum/component/fattening
	dupe_mode = COMPONENT_DUPE_UNIQUE

	// basic settings
	// how much real_fat is being added from interaction
	var/real_fatness_amount
	// how much perma_fat is being added from interaction
	var/perma_fatness_amount = 0
	// type of fattening
	var/fattening_type = FATTENING_TYPE_MAGIC
	// whether we ignore the WG/L rate
	var/ignore_rate = FALSE

	// toggleable use cases
	// do we get fat from being touched with hands
	var/touch = FALSE
	// do we get fat from being touched with items
	var/item_touch = FALSE
	// do we get fat from being bumped
	var/bumped = FALSE
	// do we get fat from passing through. Currently does not work
	// var/pass_through = FALSE

/**
 * Initialize the fattening component behaviour
 *
 * When applied to any atom in the game, touching it will cause the touching person to gain weight
 *
 * Arguments:
 * * real_fatness_amount - amount of real_fat the touching person obtains. Required
 * * fattening_type - the type of fattening (item, weapon, magic, etc). Required
 * * perma_fatness_amount - amount of perma fatness the touching person obtains. Default 0
 * * ignore_rate - do we ignore WG/L rate. Default FALSE
 * * touch - can we be fattened by touching this with out bare hands. Default TRUE
 * * item_touch - can we be fattened despite using an item to interact with the object. Default FALSE
 * * bumped - can we be fattened by bumping into this object. Default TRUE
 */
/datum/component/fattening/Initialize(
	real_fatness_amount,
	fattening_type,
	perma_fatness_amount = 0,
	ignore_rate = FALSE,
	touch = TRUE,
	item_touch = FALSE,
	bumped = TRUE,
	// pass_through = FALSE
)
	src.real_fatness_amount = real_fatness_amount
	src.fattening_type = fattening_type
	src.perma_fatness_amount = perma_fatness_amount
	src.ignore_rate = ignore_rate
	src.touch = touch
	src.item_touch = item_touch
	src.bumped = bumped
	// src.pass_through = pass_through

	if (touch)
		RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(touch))
	if (bumped)
		RegisterSignal(parent, COMSIG_ATOM_BUMPED, PROC_REF(bump))
	if (item_touch)
		RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(item_touch))


/**
 * fattens given carbon
 *
 * This assumes it was called from other procs of this component, and thus that we've already
 * made sure that the mob is in fact a carbon
 *
 * Arguments:
 * * user - the person touching us, and therefore getting fat
 *
 */
/datum/component/fattening/proc/fatten(mob/living/carbon/fatty)
	fatty.adjust_fatness(real_fatness_amount, fattening_type, ignore_rate)
	fatty.adjust_perma(perma_fatness_amount, fattening_type, ignore_rate)

/**
 * receives a signal when our object was touched by an empty hand. If the mob
 * is a carbon, checks if they have gloves on. If they don't, calls fatten of them.
 * If they are wearing gloves, it checks if we can fatten through items, and if yes, calls fatten on them.
 * Returns False otherwise
 */
/datum/component/fattening/proc/touch(atom/parent, mob/user)
	SIGNAL_HANDLER
	if (!ishuman(user))
		return FALSE

	var/mob/living/carbon/human/fatty = user
	// if we have gloves on, don't fatten. Unless we can fatten through items, then fuckem
	if (!isnull(fatty.gloves) && !item_touch)
		return FALSE
	fatten(fatty)

/**
 * receives a signal for when our objects gets bumped into by another mob. If the mob
 * is a carbon, calls fatten on them. Returns False otherwise
 */
/datum/component/fattening/proc/bump(datum/source, atom/movable/bumped_atom)
	SIGNAL_HANDLER
	if (!iscarbon(bumped_atom))
		return

	var/mob/living/carbon/fatty = bumped_atom
	fatten(fatty)

/**
 * receives a signal for when our object gets touched through an item. If the person holding
 * the item is a carbon, calls fatten on them. Returns False otherwise
 */
/datum/component/fattening/proc/item_touch(datum/source, obj/item/attacking_item, mob/living/user, params)
	SIGNAL_HANDLER
	if (!iscarbon(user))
		return FALSE

	var/mob/living/carbon/fatty = user
	fatten(fatty)

/**
 * receives a signal for when another atom enters the turf of our object. If that atom
 * is a carbon, calls fatten on them. Returns False otherwise
 * Right now does not work
 */
/datum/component/fattening/proc/pass_through(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if (!iscarbon(arrived))
		return FALSE

	var/mob/living/carbon/fatty = arrived
	fatten(fatty)
