/// Crew that needs to be moving around, think stuff like security officers or Captain
#define CREW_FATNESS_CUTOFF_IMPORTANT FATNESS_LEVEL_MORBIDLY_OBESE
/// Crew that still needs to be in arguably decent physical shape, but can slouch a bit.
#define CREW_FATNESS_CUTOFF_SEMI_IMPORTANT FATNESS_LEVEL_IMMOBILE
// Move this to seperate files for each job if there is a point where a large amount of variables are set.

/datum/job/assistant
	max_hardcore_fatty_weight = FALSE

/datum/job/prisoner // That good RP
	max_hardcore_fatty_weight = FALSE

// Semi important jobs
/datum/job/quartermaster
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

/datum/job/chief_medical_officer
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

/datum/job/head_of_personnel
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

/datum/job/doctor
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

/datum/job/station_engineer
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

/datum/job/detective
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

/datum/job/shaft_miner
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

/datum/job/security_medic
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_SEMI_IMPORTANT

// Very important jobs
/datum/job/security_officer
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_IMPORTANT

/datum/job/warden
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_IMPORTANT

/datum/job/head_of_security
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_IMPORTANT

/datum/job/blueshield
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_IMPORTANT

/datum/job/captain
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_IMPORTANT

/datum/job/chief_engineer
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_IMPORTANT

/datum/job/paramedic
	max_hardcore_fatty_weight = CREW_FATNESS_CUTOFF_IMPORTANT

#undef CREW_FATNESS_CUTOFF_IMPORTANT
#undef CREW_FATNESS_CUTOFF_SEMI_IMPORTANT
