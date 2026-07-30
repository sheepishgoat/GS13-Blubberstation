#define BURSTING_FULLNESS_MIN_THRESHOLD FULLNESS_LEVEL_BLOATED ///Minimum fullness threshold for doing any fullness related messages or code
#define BURSTING_FATNESS_MIN_THRESHOLD 0.4 ///Remaining percentage of the total fatness capacity needed before doing messages or code
#define BURSTING_BUFFER_REDUCTION 150 ///How much additional fatness is removed past the threshold as a buffer
#define BURSTING_FLAVOR_PROB_MAX 0.2 ///Maximum message frequency at 100% capacity
#define BURSTING_FLAVOR_PROB_MIN 0.05 ///Minimum message frequency at 0% capacity

#define BURSTING_ABOUT_TO_BURST "near_bursting" ///Trait used for checking if they're about to burst
#define BURSTING_DELAY_BURST_SECONDS 180 ///How long to delay if clicking the delay bursting button in the TGUI popup
#define BURSTING_DELAY_BURST_SECONDS_SHORT 30 ///How long to delay the TGUI popup if bursting was cancled because bursting was inturupted
#define BURSTING_CONFIRM "Burst Now!" ///Button text
#define BURSTING_DENY "Delay" ///Button text
#define BURSTING_ANIMATE_TIME 6 ///How long in seconds the animation in seconds for bursting should play
#define BURSTING_ANIMATE_SCALE_X 1.8 ///How much the player is expanded when exploding
#define BURSTING_ANIMATE_SCALE_Y 1.1

//Prefs
#define BURSTING_PREF_DISABLED 0
#define BURSTING_PREF_SAFE 1
#define BURSTING_PREF_INJURE 2
#define BURSTING_PREF_CRIT 3
#define BURSTING_PREF_FATAL 4
#define BURSTING_PREF_PERMA_FATAL 5

//Sounds
#define BURSTING_SOUND_RATIO 0.3 ///The relative ratio between fatness and fullness between eachother for sounds to play
#define BURSTING_SOUND_VOLUME 45 ///Sound volume for all the sounds
#define BURSTING_CRESCENDO "modular_gs/sound/effects/inflation/pop/bursting_crescendo.ogg"
#define BURSTING_CRESCENDO_DELAY "modular_gs/sound/effects/inflation/berryloop.ogg"
#define BURSTING_BURST "modular_gs/sound/effects/inflation/pop/burst_thump.ogg"
#define BURSTING_GURGLE_SOUNDS list(\
	'modular_gs/sound/voice/gurgle1.ogg',\
	'modular_gs/sound/voice/gurgle2.ogg',\
	'modular_gs/sound/voice/gurgle3.ogg'\
)

#define BURSTING_FAT_SLOSH_SOUNDS list(\
	'modular_gs/sound/effects/inflation/sloshing/slosh_1.ogg',\
	'modular_gs/sound/effects/inflation/sloshing/slosh_2.ogg',\
	'modular_gs/sound/effects/inflation/sloshing/slosh_3.ogg'\
)

#define BURSTING_FLAVOR_FULL list(\
	"Phew... I'm stuffed...",\
	"Feeling pretty full...",\
	"So stuffed...",\
	"Oof... so full...",\
	"You feel a slight heft in your stomach..."\
)

#define BURSTING_FLAVOR_STUFFED list(\
	"Ough... So much...",\
	"I feel so full...",\
	"I couldn't eat another bite...",\
	"Too... full...",\
	"You feel your stomach groan with fullness",\
	"Your stomach sloshes with fullness as you move",\
	"You feel extremely full",\
	"Your belly bloats to make room"\
)

#define BURSTING_FLAVOR_OVERSTUFFED list(\
	"Can't... hold... any... more...",\
	"Too... much...",\
	"Ugh... getting too... full...",\
	"Can't... eat... any more...",\
	"Your belly swells with pressure",\
	"Your stomach rumbles with fullness",\
	"You feel immensely full",\
	"You feel your belly churn and gurgle with fullness"\
)

#define BURSTING_FLAVOR_NEARBURST list(\
	"Too... full... gonna... burst...",\
	"Can't hold it...",\
	"Too much...! I'm gonna... burst...",\
	"My stomach's... Too... full...",\
	"You feel like your stomach is way too full!",\
	"Your stomach rumbles and groans, you're way too full!",\
	"You feel your belly stretch and creak as it struggles to make room"\
)

#define BURSTING_FLAVOR_VERYFAT list(\
	"I'm so heavy...",\
	"So soft...",\
	"I feel so soft...",\
	"My body's so jiggly...",\
	"You're feeling quite heavy"\
)

#define BURSTING_FLAVOR_SUPEROBESE list(\
	"Getting so big...",\
	"I'm getting so... fat...",\
	"So heavy... so squishy...",\
	"hff... I'm so fat... so wobbly...",\
	"You feel your body wobble with fat",\
	"Fat swells your body even bigger",\
	"Your body feels quite heavy",\
	"You feel your rolls of fat swell bigger"\
)

#define BURSTING_FLAVOR_EXTREMELYDOUGHY list(\
	"Getting... too... huge...",\
	"hff... too much... fat..",\
	"So much fat... I can't...",\
	"I'm getting so... heavy... So doughy...",\
	"Your rolls swell together as your fat swells larger",\
	"Your body stetches as your fat swells inside you!",\
	"You feel extremely heavy",\
	"Your massive body wobbles as fat swells you bigger",\
)

#define BURSTING_FLAVOR_OVERWHELMING_FATNESS list(\
	"Getting... way too... massive...",\
	"Too... fat... gonna... burst...",\
	"Too much fat... Can't... hold it...! I'm gonna burst!",\
	"There's too much fat... I'm getting too... big",\
	"Your extremely fat body wobbles as fat begins to overwhelm you!",\
	"You feel like you're about to burst, your body is getting too fat!",\
	"You feel your body creak and rumble as your fat body swells",\
	"Your rolls squeeze together and creak as growing fat swells them tight"\
)

///Returns true if the capacity percentage is above a certain percentage of the other
#define BURSTING_MACRO_CHECK_THRESHOLD(percentageA, percentageB) (percentageA > percentageB * BURSTING_SOUND_RATIO)

///Gets the players bursting type pref, returns a number coresponding to said pref
/mob/living/carbon/human/proc/get_bursting_pref()
	switch(client?.prefs?.read_preference(/datum/preference/choiced/glutton_bursting_type))
		if (BURSTING_TYPE_PREF_SAFE)
			return BURSTING_PREF_SAFE

		if (BURSTING_TYPE_PREF_INJURE)
			return BURSTING_PREF_INJURE

		if (BURSTING_TYPE_PREF_CRIT)
			return BURSTING_PREF_CRIT

		if (BURSTING_TYPE_PREF_FATAL)
			return BURSTING_PREF_FATAL

		if (BURSTING_TYPE_PREF_PERMA_FATAL)
			return BURSTING_PREF_PERMA_FATAL

		else
			return BURSTING_PREF_DISABLED

/mob/living/carbon/human
	///How full is the player according to their bursting prefs
	var/bursting_capacity_fullness = -1
	///How fat is the player according to their bursting pref
	var/bursting_capacity_fatness = -1
	/// Their highest capacity percentage value to determine if they should burst
	var/bursting_capacity_percentage = -1

/** 
 * Handles bursting for either eating too much or having too high of a BFI. It checks
 * for preferences, handles bursting capacity, sound and messages. Also responsible for 
 * triggering the bursting prompt. Returns a bool for whether or not the character 
 * burst or is in the process of doing so.
 * 
 * The proc on carbon is for compatibility reasons; the real magic happens in the one
 * defined a few lines below on `/mob/living/carbon/human`.
 * 
 * Returns TRUE if the character has burst or is in the process of bursting
 * Returns FALSE otherwise
 */
/mob/living/carbon/proc/handle_bursting()
	return FALSE

/mob/living/carbon/human/handle_bursting()

	//Get prefs
	var/fullness_bursting_pref = client?.prefs?.read_preference(/datum/preference/numeric/helplessness/glutton_fullness_before_burst)
	var/fatness_bursting_pref = client?.prefs?.read_preference(/datum/preference/numeric/helplessness/glutton_fatness_before_burst)
	var/bursting_type_pref = get_bursting_pref()

	if (!fullness_bursting_pref && !fatness_bursting_pref) //If both fatness and fullness bursting is disabled, then return false and set to disabled values
		bursting_capacity_fullness = -1
		bursting_capacity_fatness = -1
		bursting_capacity_percentage = -1
		return FALSE

	//Adjust the thresholds to be relative to our minimum values so that the code doesn't run below a certain point
	var/relative_fatness_threshold = fatness_bursting_pref * BURSTING_FATNESS_MIN_THRESHOLD
	var/relative_fullness = max(fullness - BURSTING_FULLNESS_MIN_THRESHOLD, 0)
	var/relative_fatness = max(fatness - fatness_bursting_pref  * (1 - BURSTING_FATNESS_MIN_THRESHOLD), 0)

	//Capacity percentages
	bursting_capacity_fullness = fullness_bursting_pref != 0 ? relative_fullness / fullness_bursting_pref  : -1 ///Our glutton's fullness percentage, -1 flag if disabled
	bursting_capacity_fatness = fatness_bursting_pref != 0 ? relative_fatness / relative_fatness_threshold : -1 ///Our glutton's fatness percentage, -1 flag if disabled
	bursting_capacity_percentage = max(bursting_capacity_fullness, bursting_capacity_fatness) ///Use the greater percentage to determine if our glutton should burst, -1 if bursting types are disabled
	var/burst_type_fullness = bursting_capacity_fullness >= bursting_capacity_fatness


	if (bursting_capacity_percentage <= 0)
		return FALSE

	//The chance for a message or sound to play based on the player's current capacity percentage adjusted between min and max values
	var/flavor_message_chance = clamp((BURSTING_FLAVOR_PROB_MAX - BURSTING_FLAVOR_PROB_MIN) * bursting_capacity_percentage + BURSTING_FLAVOR_PROB_MIN, BURSTING_FLAVOR_PROB_MIN, BURSTING_FLAVOR_PROB_MAX)
	if (prob(flavor_message_chance * 100))
		//Pick a random message based on if we're too fat or full and select based on how much
		var/message_content = ""
		var/message_stage = clamp(round(bursting_capacity_percentage * 3.5 + 1), 1, 4) //Takes the capacity percentage and converts it into four equaly sized whole number 'stages' to be used as an index for selecting messages

		if (burst_type_fullness)
			message_content = pick(list(
				BURSTING_FLAVOR_FULL,
				BURSTING_FLAVOR_STUFFED,
				BURSTING_FLAVOR_OVERSTUFFED,
				BURSTING_FLAVOR_NEARBURST
			)[message_stage])
		else
			message_content = pick(list(
				BURSTING_FLAVOR_VERYFAT,
				BURSTING_FLAVOR_SUPEROBESE,
				BURSTING_FLAVOR_EXTREMELYDOUGHY,
				BURSTING_FLAVOR_OVERWHELMING_FATNESS
			)[message_stage])

		if (client?.prefs?.read_preference(/datum/preference/toggle/glutton_enable_messages)) //Check if the player wants messages
			to_chat(src, span_warning(message_content))

		if (client?.prefs?.read_preference(/datum/preference/toggle/glutton_enable_sounds)) //Check if the player wants sounds
			//Compare the two capcity percentages to each other and play sounds if they're higher than a percentage of the other
			if ((bursting_capacity_fullness > bursting_capacity_fatness * BURSTING_SOUND_RATIO)) //Do fullness sounds
				playsound(src.loc, pick(BURSTING_GURGLE_SOUNDS), BURSTING_SOUND_VOLUME, 1, 1, 1.2, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_bursting)


			if ((bursting_capacity_fatness > bursting_capacity_fullness * BURSTING_SOUND_RATIO)) //Do fatness sounds
				playsound(src.loc, pick(BURSTING_FAT_SLOSH_SOUNDS), BURSTING_SOUND_VOLUME, 1, 1, 1.2, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_bursting)

	if (!client?.prefs?.read_preference(/datum/preference/toggle/glutton_see_bursting))
		return FALSE

	if (bursting_type_pref == BURSTING_PREF_DISABLED)
		return FALSE

	if (bursting_capacity_percentage < 1)
		return FALSE

	if (HAS_TRAIT(src, BURSTING_ABOUT_TO_BURST))
		return FALSE

	trigger_glutton_burst(burst_type_fullness, bursting_type_pref)
	return TRUE

///Opens the tgui popup for deciding wether to burst or delay
/mob/living/carbon/human/proc/trigger_glutton_burst(burst_type, bursting_type_pref)
	//Add self removing trait so that bursting doesn't repeatedly trigger, dual purpose as our delay if the delay button is pressed and a cooldown to delay repeated bursting
	ADD_TRAIT(src, BURSTING_ABOUT_TO_BURST, TRAUMA_TRAIT)

	//TGUI popup to confirm bursting
	var/burst_choice = tgui_alert(
		src,
		"You've exceeded your capacity and gotten too [burst_type ? "full" : "fat"]. You're now on the verge of bursting, but you might be able to hold together a bit longer... Click '[BURSTING_CONFIRM]' if you wish to burst, you will explode after a short delay[bursting_type_pref >= BURSTING_PREF_CRIT ? ", which will kill you since you have safe bursting disabled." : "."] Otherwise, click '[BURSTING_DENY]' which will delay bursting for bit if you're still over capacity.",
		"You're about to burst!",
		list(BURSTING_CONFIRM, BURSTING_DENY)
	)
	if (burst_choice == BURSTING_CONFIRM)
		burst_choice = tgui_alert(
			src,
			"Last chance to change your mind, please confirm that you wish to burst",
			"You're about to burst!",
			list(BURSTING_CONFIRM, BURSTING_DENY)
		)

	if (burst_choice != BURSTING_CONFIRM) //They either closed the window or clicked delay, so delay for the normal delay
		addtimer(TRAIT_CALLBACK_REMOVE(src, BURSTING_ABOUT_TO_BURST, TRAUMA_TRAIT), BURSTING_DELAY_BURST_SECONDS SECONDS)
		return

	//Start the burst if confirm is clicked, which will animate our character swelling and start a callback for our bursting function
	visible_message(span_warning("[src]'s body lets out a rumble, they're about to burst!"), span_warning("Your body rumbles, you're about to burst!"))
	if(!do_after(src, 5 SECONDS, src)) //Delay for just a moment to make sure they want it, but delay the TGUI popup for a shorter time incase bursting got inturupted
		visible_message(span_warning("[src] manages to hold themselves together for now..."), span_warning("Your able to hold yourself together... for now"))
		addtimer(TRAIT_CALLBACK_REMOVE(src, BURSTING_ABOUT_TO_BURST, TRAUMA_TRAIT), BURSTING_DELAY_BURST_SECONDS_SHORT SECONDS)
		return

	//No saving them now, they're gonna burst!
	addtimer(TRAIT_CALLBACK_REMOVE(src, BURSTING_ABOUT_TO_BURST, TRAUMA_TRAIT), BURSTING_DELAY_BURST_SECONDS SECONDS)
	SEND_SIGNAL(src, COMSIG_LIVING_BURSTING_TRANSFORM_SIGNAL) //send signal that the bursting code is doing transforms, might be handy
	visible_message(span_warning("[src] begins to swell as they're overwhelmed by their [burst_type ? "fullness" : "fatness"]!"), span_warning("Your body begins to swell as your [burst_type ? "fullness" : "fatness"] overwhelms you!"))
	addtimer(CALLBACK(src, PROC_REF(burst_glutton)), BURSTING_ANIMATE_TIME SECONDS) //Bursts the character
	var/matrix/scale_transform = matrix()
	scale_transform.Scale(
		abs(BURSTING_ANIMATE_SCALE_X * cos(lying_angle) + BURSTING_ANIMATE_SCALE_Y * sin(lying_angle)),
		abs(BURSTING_ANIMATE_SCALE_Y * cos(lying_angle) + BURSTING_ANIMATE_SCALE_X * sin(lying_angle))
	)
	playsound(src.loc, BURSTING_CRESCENDO, BURSTING_SOUND_VOLUME, 1, 1, 1.2, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_bursting)
	animate(src, time = BURSTING_ANIMATE_TIME SECONDS, transform = transform * scale_transform, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
	Stun(BURSTING_ANIMATE_TIME SECONDS, TRUE)

///Makes our glutton explode, using the character's original transform to restore their shape if there's safe bursting
/mob/living/carbon/human/proc/burst_glutton()
	//Check surrounding area if anyone will see them explode who would not want to, delay for a moment
	if (!check_prefs_in_view(/datum/preference/toggle/glutton_see_bursting, src.loc))
		visible_message(
			span_warning("[src] makes a loud creak as the swelling stops on the verge of bursting, they seem to be holding together for now... (People with bursting prefs disabled are in view!)"),
			span_warning("You make a loud creak as the swelling momentarily stops as you struggle to hold together... (Someone with bursting prefs disabled is in view!)")
		)
		playsound(src.loc, BURSTING_CRESCENDO_DELAY, BURSTING_SOUND_VOLUME, 1, 1, 1.2, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_bursting)
		addtimer(CALLBACK(src, PROC_REF(burst_glutton)), 8.4 SECONDS) //Delay for the duration of the sound
		return

	var/bursting_pref = get_bursting_pref()
	if (bursting_pref != BURSTING_PREF_DISABLED) //Do one last check to make sure the player actually wanted it
		playsound(src.loc, BURSTING_BURST, BURSTING_SOUND_VOLUME, 1, 1, 1.2, ignore_walls = FALSE, volume_preference = /datum/preference/numeric/volume/sound_bursting)
		visible_message(span_warning("[src]'s body lets out a final creak before bursting!"), span_warning("You feel your body let out a creak as the pressure becomes too much before bursting!"))

		//Get the fatness pref again incase it was changed since they burst and use it to determine the reduction so that the player doesn't repeatedly burst
		var/fatness_bursting_pref = client?.prefs?.read_preference(/datum/preference/numeric/helplessness/glutton_fatness_before_burst)
		if (fatness_bursting_pref > 0)
			//Clear some fat hiders
			for (var/hider in fat_hiders)
				if (istype(hider, /datum/reagent/water))
					hider_remove(hider)
				if (istype(hider, /datum/reagent/blueberry_juice))
					hider_remove(hider)

			//Call the functions used to update fatness and hiders, since hider apply on its own wont update fatness if the hiders are removed
			calculate_fatness()

			//Start removing weight if needed
			var/weight_target = fatness_bursting_pref * (1 - BURSTING_FATNESS_MIN_THRESHOLD) - BURSTING_BUFFER_REDUCTION
			if (fatness > weight_target) //Check to see if just removing specific hiders was enough, otherwise do further reductions
				adjust_fatness(-(fatness - weight_target), FATTENING_TYPE_ALMIGHTY, TRUE) //Use almighty to bypass pref check since they've already consented to burst
				if (fatness > weight_target) //Check if that was enough then start removing perma fatness
					adjust_perma(-(fatness - weight_target), FATTENING_TYPE_ALMIGHTY, TRUE)

		switch(bursting_pref) //Get the bursting pref again incase the person changes their mind about how they'd like to burst
			if (BURSTING_PREF_FATAL)
				blueberry_gib(client?.prefs?.read_preference(/datum/preference/toggle/glutton_leave_gibs))
				return

			if (BURSTING_PREF_PERMA_FATAL)
				gib(DROP_ALL_REMAINS)
				return

			if (BURSTING_PREF_SAFE to BURSTING_PREF_CRIT)
				var/datum/effect_system/fluid_spread/smoke/burst_smoke/bursting_smoke = new(range = 2, holder = src, location = src)
				// bursting_smoke.set_up(2, holder = src, location = src)
				bursting_smoke.start()

				//Clear reagents from the stomach and blood
				organs_slot["stomach"]?:reagents?:reagent_list = list()
				reagents.reagent_list = list()

				//Injure modes
				if (bursting_pref == BURSTING_PREF_INJURE || bursting_pref == BURSTING_PREF_CRIT)
					var/bursting_chest_damage = bursting_pref == BURSTING_PREF_INJURE ? 40 : 110 ///40 damage if in injure, 110 if in crit mode
					var/bursting_limb_damage = bursting_pref == BURSTING_PREF_INJURE ? 5 : 10 ///How much damage to do to the limbs if fatness bursting
					var/bursting_stomach_damage = bursting_pref == BURSTING_PREF_INJURE ? 30 : 100 ///How much damage to do to the stomach when fullness bursting

					apply_damage(bursting_chest_damage, BRUTE, BODY_ZONE_CHEST, forced = TRUE) //Apply brunt of damage to the chest

					if (bursting_capacity_fatness > 1)
						//The whole body usually gets fat, if they burst from being too big also damage everything else
						apply_damage(bursting_limb_damage, BRUTE, BODY_ZONE_L_ARM, forced = TRUE)
						apply_damage(bursting_limb_damage, BRUTE, BODY_ZONE_R_ARM, forced = TRUE)
						apply_damage(bursting_limb_damage, BRUTE, BODY_ZONE_L_LEG, forced = TRUE)
						apply_damage(bursting_limb_damage, BRUTE, BODY_ZONE_R_LEG, forced = TRUE)

					if (bursting_capacity_fullness > 1)
						adjust_organ_loss(ORGAN_SLOT_STOMACH, bursting_stomach_damage) //Wreck the stomach if they were too full


				Unconscious(5 SECONDS, TRUE) //Bursting is intense, knock the player out for a bit

	//Return their transform back to normal with a short animation
	SEND_SIGNAL(src, COMSIG_LIVING_BURSTING_BURST) //send signal that player burst to remove pixel shifts
	var/matrix/original_transform = matrix(dna.current_body_size, 0, 0, 0, dna.current_body_size, 16 * dna.current_body_size - 16)
	animate(src, time = 1 SECONDS, transform = original_transform * matrix(lying_angle, MATRIX_ROTATE), easing = SINE_EASING)

//The smoke used for bursting
/obj/effect/particle_effect/fluid/smoke/burst_smoke
	name = "Bursting Smoke"
	color = COLOR_LIGHT_GRAYISH_RED
	lifetime = 1 SECONDS

/datum/effect_system/fluid_spread/smoke/burst_smoke
	effect_type = /obj/effect/particle_effect/fluid/smoke/burst_smoke

#undef BURSTING_FULLNESS_MIN_THRESHOLD
#undef BURSTING_FATNESS_MIN_THRESHOLD
#undef BURSTING_BUFFER_REDUCTION
#undef BURSTING_FLAVOR_PROB_MAX
#undef BURSTING_FLAVOR_PROB_MIN

#undef BURSTING_ABOUT_TO_BURST
#undef BURSTING_DELAY_BURST_SECONDS
#undef BURSTING_DELAY_BURST_SECONDS_SHORT
#undef BURSTING_CONFIRM
#undef BURSTING_DENY
#undef BURSTING_ANIMATE_TIME
#undef BURSTING_ANIMATE_SCALE_X
#undef BURSTING_ANIMATE_SCALE_Y

#undef BURSTING_PREF_DISABLED
#undef BURSTING_PREF_SAFE
#undef BURSTING_PREF_INJURE
#undef BURSTING_PREF_CRIT
#undef BURSTING_PREF_FATAL
#undef BURSTING_PREF_PERMA_FATAL

#undef BURSTING_SOUND_RATIO
#undef BURSTING_SOUND_VOLUME
#undef BURSTING_CRESCENDO
#undef BURSTING_CRESCENDO_DELAY
#undef BURSTING_BURST
#undef BURSTING_GURGLE_SOUNDS
#undef BURSTING_FAT_SLOSH_SOUNDS

#undef BURSTING_FLAVOR_FULL
#undef BURSTING_FLAVOR_STUFFED
#undef BURSTING_FLAVOR_OVERSTUFFED
#undef BURSTING_FLAVOR_NEARBURST

#undef BURSTING_FLAVOR_VERYFAT
#undef BURSTING_FLAVOR_SUPEROBESE
#undef BURSTING_FLAVOR_EXTREMELYDOUGHY
#undef BURSTING_FLAVOR_OVERWHELMING_FATNESS

#undef BURSTING_MACRO_CHECK_THRESHOLD
