/mob/living/carbon/human
	///How full is the player according to their bursting prefs
	var/bursting_capacity_fullness = -1
	///How fat is the player according to their bursting pref
	var/bursting_capacity_fatness = -1
	/// Their highest capacity percentage value to determine if they should burst
	var/bursting_capacity_percentage = -1
	/// Decides whether the user is cursed at all (also makes for a fun admin switch)
	var/cursed_fat = 0
	/// Decides on the lenght of the curse
	var/fattening_steps_left = 0
