// extends NUTRITION_LEVELs from code/__DEFINES/mobs.dm
/// the maximum default fullness
#define FULLNESS_MAX 2000
#define FULLNESS_LEVEL_NOMOREPLZ 1350
#define FULLNESS_LEVEL_BEEG 1050
#define FULLNESS_LEVEL_BLOATED 750

//Fullness emote cooldown
#define FULLNESS_REDUCTION_COOLDOWN 50

//Fatness levels, Here we go!
#define FATNESS_LEVEL_BLOB 3440
#define FATNESS_LEVEL_IMMOBILE 2540
#define FATNESS_LEVEL_BARELYMOBILE 1840
#define FATNESS_LEVEL_EXTREMELY_OBESE 1240
#define FATNESS_LEVEL_MORBIDLY_OBESE 840
#define FATNESS_LEVEL_OBESE 440
#define FATNESS_LEVEL_VERYFAT 330
#define FATNESS_LEVEL_FATTER 250
#define FATNESS_LEVEL_FAT 170
#define FATNESS_LEVEL_NONE 0

// Maximum genital sizes
#define MAX_BREASTS_SIZE 18		// HUGE mommy milkers :drooling_face:. Actually, a bit too huge so we limit them

//Math stuff for fatness movement speed
/// Maximum move speed penalty for being fat, if you don't have the weak legs trait
#define FATNESS_MAX_MOVE_PENALTY 5
/// Maximum move speed penalty with the weak legs trait
#define WEAKLEGS_MAX_MOVE_PENALTY 7
/// effective fatness gets divided by this to figure out how much slowness to apply
#define FATNESS_DIVISOR (FATNESS_LEVEL_BLOB / FATNESS_MAX_MOVE_PENALTY)
/// slowness modifier grows this many times faster
#define FATNESS_WEAKLEGS_MODIFIER (WEAKLEGS_MAX_MOVE_PENALTY / FATNESS_MAX_MOVE_PENALTY)
/// the slowdown from weight gets multiplied by this, meaning the lower this is, the lower the slowdown
#define FATNESS_STRONGLEGS_MODIFIER 0.5

#define MAX_PREFS_WEIGHT_GAIN_AND_LOSS_RATE 2
#define MIN_PREFS_WEIGHT_GAIN_AND_LOSS_RATE 0
#define DEFAULT_PREFS_WEIGHT_GAIN_AND_LOSS_RATE 0.5

// defines for weight gain/loss modifiers
#define WEIGHT_RATE_MODIFIER_MAX_VALUE		2
#define WEIGHT_RATE_MODIFIER_MIN_VALUE		-2
#define UNIVERSAL_GAINER_MINIMUM_WG_RATE	0.2
#define UNIVERSAL_GAINER_MAXIMUM_WL_RATE	0.5

#define RESIZE_MACRO 6
#define RESIZE_HUGE 4
#define RESIZE_BIG 2
#define RESIZE_NORMAL 1
#define RESIZE_SMALL 0.75
#define RESIZE_TINY 0.50
#define RESIZE_MICRO 0.25

#define MOVESPEED_ID_SIZE      "SIZECODE"
#define MOVESPEED_ID_STOMP     "STEPPY"

//averages
#define RESIZE_A_MACROHUGE (RESIZE_MACRO + RESIZE_HUGE) / 2
#define RESIZE_A_HUGEBIG (RESIZE_HUGE + RESIZE_BIG) / 2
#define RESIZE_A_BIGNORMAL (RESIZE_BIG + RESIZE_NORMAL) / 2
#define RESIZE_A_NORMALSMALL (RESIZE_NORMAL + RESIZE_SMALL) / 2
#define RESIZE_A_SMALLTINY (RESIZE_SMALL + RESIZE_TINY) / 2
#define RESIZE_A_TINYMICRO (RESIZE_TINY + RESIZE_MICRO) / 2

//Bursting types
#define BURSTING_TYPE_PREF_DISABLE "Disabled"
#define BURSTING_TYPE_PREF_SAFE "Safe"
#define BURSTING_TYPE_PREF_INJURE "Injure"
#define BURSTING_TYPE_PREF_CRIT "Crit"
#define BURSTING_TYPE_PREF_FATAL "Gib and cryo"
#define BURSTING_TYPE_PREF_PERMA_FATAL "Gib and drop head"
