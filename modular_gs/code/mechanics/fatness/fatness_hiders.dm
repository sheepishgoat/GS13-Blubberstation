/*
THE FATNESS HIDING GUIDE!!!
HOW 2 FATNESS HIDE
Step 1) Grab a thing that will add or reduce fatness!
Step 2) Give it a character.hider_add(src) and a character.hider_remove(src) depending on the conditions you want it to meet for which it will add or remove itself from messing with a character's fatness!
Step 3) Give it a proc/fat_hide([character argument]), with a return that will give the amount to shift that character's fatness by!
Step 4) There is no step 4, you did it bucko!
Wanna see an example? Search for /obj/item/bluespace_belt !!!
*/
/**
 * Adds `hide_source` to the list of things that will hide our fatness
 * 
 * hide_source - the element that is supposed to hide our fatness. Make sure it has the `fat_hide` proc
 */
/mob/living/carbon/proc/hider_add(hide_source)
	if(!(hide_source in fat_hiders))
		fat_hiders += hide_source

	return TRUE

/**
 * Removes `hide_source` from the list of things that will hide our fatness
 * 
 * hide_source - the element that we want to remove froum our hiders
 */
/mob/living/carbon/proc/hider_remove(hide_source)
	if(hide_source in fat_hiders)
		fat_hiders -= hide_source

	return TRUE

/// Calculates the total value of fat that we're supposed to hide
/mob/living/carbon/proc/hiders_calc()
	var/hiders_value = 0
	for(var/hider in fat_hiders)
		var/hide_values = hider:fat_hide(src)
		if(!islist(hide_values))
			hiders_value += hide_values
		else
			for(var/hide_value in hide_values)
				hiders_value += hide_value

	return hiders_value

/// Applies our fat hiders
/mob/living/carbon/proc/hiders_apply()
	if(fat_hiders) //do we have any hiders active?
		var/fatness_over = hiders_calc() //calculate the sum of all hiders
		fatness = fatness + fatness_over //Then, make their current fatness the sum of their real plus/minus the calculated amount
		if(max_weight) //Check their prefs
			fatness = min(fatness, (max_weight - 1)) //And make sure it's not above their preferred max
