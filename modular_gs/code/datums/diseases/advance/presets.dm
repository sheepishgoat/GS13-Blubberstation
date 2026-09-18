/datum/disease/advance/weight_gain
	copy_type = /datum/disease/advance

/datum/disease/advance/weight_gain/New()
	name = "Weight Gain disease"
	symptoms = list(new/datum/symptom/weight_gain)
	..()

/datum/disease/advance/berry
	copy_type = /datum/disease/advance

/datum/disease/advance/berry/New()
	name = "Berry disease"
	symptoms = list(new/datum/symptom/berry)
	..()

/// Get stats from variables rather than disease symptoms
/datum/disease/advance/preset
	var/stage_speed = 0
	var/stealth = 0
	var/resistance = 0
	var/transmittable = 0
	var/custom_severity = 0

	// This isn't set here, but the visibility_flags variable is useful for making stealth viruses
	mutable = FALSE


/datum/disease/advance/preset/GenerateProperties()
	properties = list("resistance" = 0, "stealth" = 0, "stage_rate" = 0, "transmittable" = 0, "severity" = 0)

	properties["resistance"] += resistance
	properties["stealth"] += stealth
	properties["stage_rate"] += stage_speed
	properties["transmittable"] += transmittable
	if(custom_severity)
		properties["severity"] = custom_severity

	if(properties["severity"] > 0)
		properties["severity"] += round((properties["resistance"] / 12), 1)
		properties["severity"] += round((properties["stage_rate"] / 11), 1)
		properties["severity"] += round((properties["transmittable"] / 8), 1)
		properties["severity"] = round((properties["severity"] / 2), 1)
		properties["severity"] = round(clamp(properties["severity"], 1, 7), 1)


/datum/disease/advance/preset/berry
	copy_type = /datum/disease/advance

/datum/disease/advance/preset/berry/New()
	name = "Berry disease"
	symptoms = list(new/datum/symptom/berry)
	..()

/// A berry preset designed to mimic the stats of the fastest berry virus you can normally make
/datum/disease/advance/preset/berry/viro_max
	stealth = -2
	resistance = 3
	stage_speed = 19
	transmittable = 12
	custom_severity = 4

// non-transmittable, but more stealth
/datum/disease/advance/preset/berry/viro_max/single_target
	stealth = 3
	transmittable = -10

/datum/disease/advance/preset/berry/very_strong
	stealth = 14
	resistance = 23
	stage_speed = 40 // God help them.
	transmittable = 19
	custom_severity = 7


/datum/disease/advance/preset/berry/very_strong/reduced_transmission
	transmittable = -10


// death for berryboy
/datum/disease/advance/preset/berry/very_strong/smite
	resistance  = 30
	transmittable = -10
	stage_speed = 80 // They are cooked.


