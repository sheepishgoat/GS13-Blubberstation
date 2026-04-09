/datum/augment_item/limb
	category = AUGMENT_CATEGORY_LIMBS
	allowed_biotypes = MOB_ORGANIC|MOB_ROBOTIC
	///Hardcoded styles that can be chosen from and apply to limb, if it's true
	var/uses_robotic_styles = TRUE
	///Should we draw these greyscale?
	var/uses_greyscale = FALSE

/datum/augment_item/limb/apply(mob/living/carbon/human/augmented, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup)

@@ -20,129 +22,132 @@
			old_limb.set_icon_static(chosen_style)
			old_limb.current_style = prefs.augment_limb_styles[slot]
		else
			old_limb.set_icon_static(initial(new_limb.icon))
		old_limb.should_draw_greyscale = FALSE
			if(!uses_greyscale)
				old_limb.set_icon_static(initial(new_limb.icon))
			else
				old_limb.set_icon_greyscale(UNLINT(initial(new_limb.icon_greyscale))) // stupid var_protected memes
		old_limb.should_draw_greyscale = uses_greyscale

		return body_zone
	else
		var/obj/item/bodypart/new_limb = new path(augmented)
		var/obj/item/bodypart/old_limb = augmented.get_bodypart(new_limb.body_zone)
		if(uses_robotic_styles && prefs.augment_limb_styles[slot])
			var/chosen_style = GLOB.robotic_styles_list[prefs.augment_limb_styles[slot]]
			new_limb.set_icon_static(chosen_style)
			new_limb.current_style = prefs.augment_limb_styles[slot]
		new_limb.replace_limb(augmented, special = TRUE)
		qdel(old_limb)
