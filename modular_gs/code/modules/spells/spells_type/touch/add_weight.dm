/datum/action/cooldown/spell/touch/fatten_up
	name = "Gain"
	desc = "This spell charges your hand with the power of calorite to make those who are touched fatter"
	button_icon = 'modular_gs/icons/obj/spells/spell_items.dmi'
	button_icon_state = "add-hand"
	sound = 'sound/effects/blob/attackblob.ogg'

	school = SCHOOL_LIPOMANCY
	cooldown_time = 30 SECONDS
	cooldown_reduction_per_rank = 10 SECONDS
	spell_requirements = NONE

	invocation = "TUB-O-LARDO!!"

	hand_path = /obj/item/melee/touch_attack/fatten_up

/datum/action/cooldown/spell/touch/fatten_up/on_antimagic_triggered(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	to_chat(caster, span_warning("The spell can't seem to affect [victim]!"))
	to_chat(victim, span_warning("You feel your body try to gain some weight - but you might as well just be skin and bones!"))

/datum/action/cooldown/spell/touch/fatten_up/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	var/mob/living/carbon/living_victim = victim
	if(living_victim.can_block_magic(antimagic_flags))
		return TRUE

	if(!istype(living_victim))
		return FALSE

	living_victim.adjust_fatness(100, FATTENING_TYPE_MAGIC)
	return TRUE

/obj/item/melee/touch_attack/fatten_up
	name = "\improper fattening touch"
	desc = "Until you can't move, fatass!"
	icon = 'modular_gs/icons/obj/spells/spell_items.dmi'
	icon_state = "add-hand"
	inhand_icon_state = "add-hand"
