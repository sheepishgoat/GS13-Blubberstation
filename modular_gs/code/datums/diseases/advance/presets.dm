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
