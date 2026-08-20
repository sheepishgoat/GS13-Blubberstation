#define COMSIG_WEIGHT_ADJUSTED "comsig_weight_adjusted"

/* Fatness change signals
These signals are called when their respective "adjust" function is called. You can listen for both the
`COMSIG_FATNESS_REAL_CHANGED` and `COMSIG_FATNESS_PERMA_CHANGED` at the same time, but try to avoid mixing
them with the `COMSIG_FATNESS_CHANGED` signal, as this will result in you obtaining 2 signals each time
any of the fatness variables changes
*/
/// Called by `/mob/living/carbon/adjust_fatness` when `fatness_real` is changed. 
/// Passes `fatness_real`.
#define COMSIG_FATNESS_REAL_CHANGED "fatness_real_changed"
/// Called by `/mob/living/carbon/adjust_perma` when `fatness_perma` is changed. 
/// Passes the `fatness_perma`.
#define COMSIG_FATNESS_PERMA_CHANGED "fatness_perma_changed"
/// Called by `/mob/living/carbon/calculate_fatness()` after `fatness` is calculated. 
/// Passes `fatness`
#define COMSIG_FATNESS_CHANGED "fatness_changed"

// bursting
///Signal that bursting is doing transforms to the player
#define COMSIG_LIVING_BURSTING_TRANSFORM_SIGNAL "signal_living_bursting_transformation"
///Signal that the player has burst and is having transforms done
#define COMSIG_LIVING_BURSTING_BURST "signal_living_bursting_burst"
