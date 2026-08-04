#define MINIMUM_FATNESS_LEVEL 0

#define FATTENING_TYPE_ITEM "item"
#define FATTENING_TYPE_FOOD "food"
#define FATTENING_TYPE_CHEM "chem"
#define FATTENING_TYPE_WEAPON "weapon"
#define FATTENING_TYPE_MAGIC "magic"
#define FATTENING_TYPE_VIRUS "virus"
#define FATTENING_TYPE_NANITES "nanites"
#define FATTENING_TYPE_ATMOS "atmos"	// yeah I'm taking the name atmos instead of gasses, because fuck you I'm not calling my pref "inflation type gas", some people will get confused, if you wanna do inflation just call it that lol
#define FATTENING_TYPE_RADIATIONS "radiations"
#define FATTENING_TYPE_MOBS "mobs"
#define FATTENING_TYPE_WEIGHT_LOSS "weight_loss"
/// This ignores prefs, please only use this for admin stuff or when you have a VERY good reason.
#define FATTENING_TYPE_ALMIGHTY "almighty"

#define FATNESS_TO_WEIGHT_RATIO 0.25
#define MUSCLE_TO_WEIGHT_RATIO 0.5 // Muscle is heavier than fat.
#define POUNDS_TO_KG_RAITO 0.454 // This isn't exact, but we don't want super long numbers.

#define MUSCLE_TO_FATNESS_RATIO 2
#define MUSCLE_TO_FATNESS_RATIO_VORE 5

#define FATNESS_FROM_VORE 0.8
#define BASE_WEIGHT_VALUE 140

#define VORE_TRANSFER_PERMAFAT 0.2
#define VORE_TRANSFER_CALORITE_POISONING 0.1

#define ABSORB_TICKS_PER_STAGE_SMALL 8
#define ABSORB_TICKS_PER_STAGE_MEDIUM 16
#define ABSORB_TICKS_PER_STAGE_LARGE 32
#define ABSORB_TICKS_PER_STAGE_EXCESS 64
#define ABSORB_TICKS_PER_STAGE_EXTREME 124

#define ABSORB_WEIGHT_AMOUNT_SMALL 175
#define ABSORB_WEIGHT_AMOUNT_MEDIUM 600
#define ABSORB_WEIGHT_AMOUNT_LARGE 1200
#define ABSORB_WEIGHT_AMOUNT_EXCESS 2300


/// for interaction datums, defines an interaction which can ONLY be performed on ourselves
#define INTERACTION_ONLY_SELF "only_self"

/// Weight Related Spells School
#define SCHOOL_LIPOMANCY "fattening"
