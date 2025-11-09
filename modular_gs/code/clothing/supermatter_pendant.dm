#define SM_PENDANT_COOLDOWN "supermatter_pendant_cooldown"

/obj/item/clothing/neck/supermatter_pendant
	name = "Supermatter Pendant"
	desc = "A tiny capsule containing a piece of the Supermatter crystal, suspended in Hyper-Noblium gas."
	icon = 'modular_gs/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_gs/icons/mob/clothing/neck.dmi'
	icon_state = "supermatter_pendant"
	w_class = WEIGHT_CLASS_TINY
	strip_delay = 2 SECONDS
	equip_delay_other = 2 SECONDS
	actions_types = list(/datum/action/item_action/toggle_light)
	action_slots = ALL
	light_system = OVERLAY_LIGHT
	light_color = COLOR_VERY_SOFT_YELLOW
	light_range = 2
	light_power = 1
	light_on = FALSE
	COOLDOWN_DECLARE(disabled_time)
	var/start_on = FALSE

/obj/item/clothing/neck/supermatter_pendant/Initialize(mapload)
	. = ..()
	if(start_on)
		set_light_on(TRUE)

/obj/item/clothing/neck/supermatter_pendant/proc/update_brightness()
	update_appearance(UPDATE_ICON)
	if(light_system == COMPLEX_LIGHT)
		update_light()

/obj/item/clothing/neck/supermatter_pendant/proc/toggle_light(mob/user)
	if(!COOLDOWN_FINISHED(src, disabled_time))
		if(user)
			balloon_alert(user, "disrupted!")
		set_light_on(FALSE)
		update_brightness()
		update_item_action_buttons()
		return FALSE
	var/old_light_on = light_on
	set_light_on(!light_on)
	update_brightness()
	update_item_action_buttons()
	if (TIMER_COOLDOWN_FINISHED(src, SM_PENDANT_COOLDOWN))
		playsound(src, SFX_SM_CALM, 25, FALSE, 40, 30, falloff_distance = 10)
		TIMER_COOLDOWN_START(src, SM_PENDANT_COOLDOWN, 2 SECONDS)
	return light_on != old_light_on // If the value of light_on didn't change, return false. Otherwise true.

/obj/item/clothing/neck/supermatter_pendant/attack_self(mob/user)
	return toggle_light(user)

/obj/item/clothing/neck/supermatter_pendant/attack_hand_secondary(mob/user, list/modifiers)
	attack_self(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/neck/supermatter_pendant/suicide_act(mob/living/carbon/human/user)
	user.visible_message(span_suicide("[user] is opening the top of [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(src, SFX_SM_DELAM, 25, FALSE, 40, 30, falloff_distance = 10)
	user.visible_message(span_danger("\The [user] touches the [src] inducing a resonance... [user.p_their()] body starts to glow and burst into flames before flashing into dust!"),
		span_userdanger("You touch the exposed crystal within the [src] as your ears are filled with unearthly ringing. Your last thought is \"Ah, shit.\""),
		span_hear("You hear an unearthly noise as a wave of heat washes over you."))
	user.dust(force = TRUE)
	return MANUAL_SUICIDE

#undef SM_PENDANT_COOLDOWN