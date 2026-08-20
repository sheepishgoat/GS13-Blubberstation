/obj/item/toy/plush/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(attempt_to_feed(tool, user))
		return
	
	return ..()

/obj/item/toy/plush/gs13
	name = "gs13 plush"
	desc = "You're not supposed to see this..."
	icon = 'modular_gs/icons/obj/plushes.dmi'
	icon_state = "gatito"

/obj/item/toy/plush/gs13/amogus
	name = "Amingas Prushie"
	desc = "Brain hemorrhage."
	icon_state = "yongas"

/obj/item/toy/plush/gs13/catgirl/fi
	name = "Annoying Catgirl plush"
	desc = "An adorable stuffed toy that resembles a very enthusiastic catgirl. Its smug aura mocks you."
	icon_state = "fi"

/obj/item/toy/plush/gs13/tertia
	name = "Blue Glorper plush"
	desc = "An adorable stuffed toy that resembles a mischevious yet helpful slime-goat. It seems to have a mysterious smirk."
	icon_state = "tertia"

/obj/item/toy/plush/gs13/primus
	name = "Magenta Glorper plush"
	desc = "An adorable stuffed toy that resembles a mad scientist goat. Its hair seems to be quite messy."
	icon_state = "primus"

/obj/item/toy/plush/gs13/melony
	name = "Ourple Deer plush"
	desc = "A plump looking deer with a red circle on her belly. She seems to have a tired but a welcoming gaze."
	icon_state = "melony"

/obj/item/toy/plush/gs13/rose
	name = "Plant Snake plush"
	desc = "An energetic looking snake toy with a silly little rose hanging from the side of his head."
	icon_state = "rose"
	stuffed_icon_state = "rose_stuffed"
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/kinichi
	name = "Jani-liz plush"
	desc = "A silly looking plushie of an adorable lizard janitor. His smile is heartwarming to look at."
	icon_state = "kinichi"

/obj/item/toy/plush/gs13/lgo
	name = "Trashbot plush"
	desc = "An attempt to market one of cleaning machines from the local market, in the form of a purchasable plushie."
	icon_state = "lgo"
	can_eat_food = TRUE
	edible_object_types = list(/obj/item/food, /obj/item/stack/sheet/cotton, /obj/item/trash)

/obj/item/toy/plush/gs13/oliver
	name = "Sharkie plush"
	desc = "A plush of a silly shark with a stylish bandanna."
	icon_state = "oliver"

/obj/item/toy/plush/gs13/chloe
	name = "Green-Eyed Botanist plush"
	desc = "A plush of a chunky red-haired botanist."
	icon_state = "chloe"

/obj/item/toy/plush/gs13/delta
	name = "Greaseball plush"
	desc = "A plush of a chunky greaseball."
	icon_state = "delta"

/obj/item/toy/plush/gs13/metis
	name = "Nerdy Gote plush"
	desc = "A plush of black-furred nerdy goat. Made with materials."
	icon_state = "metis"
	prey_plush = TRUE
	can_eat_food = TRUE
	stuffed_icon_state = "metis_stuffed"
	fatness_to_max = 15

/obj/item/toy/plush/gs13/sharky
	name = "Sharky plush"
	desc = "A plush of a toothy, sharky creature."
	icon_state = "sharky"

/obj/item/toy/plush/gs13/kot
	name = "Illiterate Demon plushie"
	desc = "A plush of a pale demon twink."
	icon_state = "kot"

/obj/item/toy/plush/gs13/gatito
	name = "Gatito plushie"
	desc = "Cutie kitty meow meow gatito plushie! Corporate flavor!!"
	icon_state = "gatito"
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/sam
	name = "Blueish Fopps plushie"
	desc = "If he was green, he would die."
	icon_state = "sam"
	stuffed_icon_state = "sam_stuffed"
	pred_plush = TRUE
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/flint
	name = "Flimbus plushie"
	desc = "Fill him with oil and throw him at a wall!"
	icon_state = "flint"
	pred_plush = TRUE
	can_eat_food = TRUE
	edible_object_types = list(/obj/item/food, /obj/item/stack/sheet/cotton, /obj/item/trash)

/obj/item/toy/plush/gs13/protogen
	name = "Proto-orb plushie"
	desc = "A round proto-orb plushie. Despite her shape, she looks like she likes to exercise."
	icon_state = "proot"

/obj/item/toy/plush/gs13/yeen
	name = "Grumpy hyena plushie"
	desc = "This hyena's one eye looks full of harmful intent."
	icon_state = "yeen"
	stuffed_icon_state = "yeen_stuffed"
	pred_plush = TRUE
	can_eat_food = TRUE
	digestion_divider = 1.5 // Apex metabolism
	fatness_to_max = 30 // She's a big gal, for you.

/obj/item/toy/plush/gs13/noms
	name = "Strange blue creature plushie"
	desc = "A large, very unwieldly plush toy of cargo's biggest workplace hazard. a small tag says \"squeeze me!\" on the seam of one of the legs."
	icon = 'modular_gs/icons/obj/plushes_big.dmi'
	icon_state = "noms"
	stuffed_icon_state = "noms_stuffed"
	pred_plush = TRUE
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/fala
	name = "Fala'squee plushie"
	desc = "A rotund green beast of whimsy and mischief. Chaos twists and reality bends in its presence, defying all known laws and rules for the benefit of its whims. Dare you wield its visage and shape along with your adventures? A low rumble emits from the plush every so often, expressing its hunger for new experiences...      Or that could just be your tummy telling you you're hungry"
	icon_state = "fala"
	stuffed_icon_state = "fala_stuffed"
	pred_plush = TRUE
	prey_plush = TRUE
	can_eat_food = TRUE
	max_plushie_scale = 1.5 // Already pretty huge

/obj/item/toy/plush/gs13/val
	name = "Abhorrent Fen plushie"
	desc = "You feel like it's staring at you... it's quite unnerving."
	icon_state = "val"
	stuffed_icon_state = "val_stuffed"
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/isaac
	name = "Plump dragon plush"
	desc = "If he were green, he too would die.."
	icon_state = "isaac"
	stuffed_icon_state = "isaac_stuffed"
	can_eat_food = TRUE
	pred_plush = TRUE
	prey_plush = TRUE

/obj/item/toy/plush/gs13/kiki
	name = "Trashy racc plush"
	desc = "It has such a smug face for such a small plushie."
	icon_state = "kiki"
	stuffed_icon_state = "kiki_stuffed"
	can_eat_food = TRUE
	pred_plush = TRUE
	prey_plush = TRUE

/obj/item/toy/plush/gs13/marina
	name = "Visage of the Moron"
	desc = "Prepare all your senses (yes, all of them!) for a new level of nonsense!  Cuddle them, squeeze them, soak them in milk!  The Moronic Visage will keep you company whether you want too or not"
	icon_state = "marina"
	stuffed_icon_state = "marina_stuffed"
	can_eat_food = TRUE
	pred_plush = TRUE
	prey_plush = TRUE

/obj/item/toy/plush/gs13/isaac_hyper
	name = "Weird Dragon Thingy Plush"
	desc = "It looks like this was someones first time making a toy, and it's shoddily made. There is a lot of heart put into it, so much that it feels warm when you hug it! But that could be the uranium..."
	icon_state = "isaac_hyper"
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/mako
	name = "Makoling plush"
	desc = "Soda cans not included. She liters enough as is..."
	icon_state = "mako"

/obj/item/toy/plush/gs13/swan
	name = "Swan plush"
	desc = "An adorable plushie of everyone's beloved waterbird. Now with an equippable hat!"
	icon_state = "swan"
	var/brim = FALSE

/obj/item/toy/plush/gs13/swan/cowboy
	name = "Cowboy Swan plush"
	icon_state = "swan-brim"
	brim = TRUE

/obj/item/toy/plush/gs13/swan/examine(mob/user)
	. = ..()
	. += span_notice("You can alt-click it to toggle the brim.")

/obj/item/toy/plush/gs13/swan/click_alt(mob/user)
	if (brim)
		name = "Swan plush"
		icon_state = "swan"
		brim = FALSE
	else
		name = "Cowboy Swan plush"
		icon_state = "swan-brim"
		brim = TRUE
	return TRUE

/obj/item/toy/plush/gs13/voltz
	name = "Battery dragon plushie"
	desc = "A large and soft plushie depicting the prince of rexora-3 in a more marketable form. Though it doesn't explain why there's a battery slot in the back, or why the horns are metal..."
	icon_state = "voltz"
	pred_plush = TRUE
	prey_plush = FALSE
	can_eat_food = TRUE
	/// shocker to handle the SHOCKING behavior
	var/obj/item/kinky_shocker/shocker

/obj/item/toy/plush/gs13/voltz/examine(mob/user)
	. = ..()
	if(shocker.cell)
		. += span_notice("\The [src] is [round(shocker.cell.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

/obj/item/toy/plush/gs13/voltz/Initialize(mapload)
	. = ..()
	shocker = new /obj/item/kinky_shocker
	shocker.preload_cell_type = null
	shocker.cell = null

/obj/item/toy/plush/gs13/voltz/attackby(obj/item/item, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	. = shocker.attackby(item, user, modifiers, attack_modifiers)

/obj/item/toy/plush/gs13/voltz/click_alt(mob/user)
	var/obj/item/stock_parts/power_store/cell/cell = shocker.cell
	if(!(cell))
		return
	cell.update_appearance()
	cell.forceMove(get_turf(src))
	shocker.cell = null
	to_chat(user, span_notice("You remove the cell from [src]."))
	shocker.shocker_on = FALSE
	// update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/toy/plush/gs13/voltz/attack_self(mob/user)
	. = shocker.attack_self(user)

/obj/item/toy/plush/gs13/voltz/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	. = shocker.attack(target_mob, user, modifiers, attack_modifiers)

/obj/item/toy/plush/gs13/blake
	name = "Friendly Lizard"
	desc = "This version is known to try and be friends with all the others plushes."
	icon_state = "blake"
	stuffed_icon_state = "blake_stuffed"
	pred_plush = TRUE
	prey_plush = TRUE
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/balian
	name = "Scholarly Badger Plushie"
	desc = "This professorial plush would look right at home sat behind a lectern; though you worry he'd start on a three hour lecture on the history of the Roman Empire. Unless you distract him with cake first. Lots of cake."
	icon_state = "balian"
	stuffed_icon_state = "balian_stuffed"
	pred_plush = TRUE
	prey_plush = FALSE
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/remmy
	name = "Clueless Dragon Plushie"
	desc = "Now back in style with 100% more fur!"
	icon_state = "remmy"
	stuffed_icon_state = "remmy_stuffed"
	pred_plush = TRUE
	prey_plush = TRUE
	can_eat_food = TRUE

/obj/item/toy/plush/gs13/duke
	name = "Small Kitsune Plushie"
	desc = "This plush really wants to be a good boy."
	icon_state = "duke"
	stuffed_icon_state = "duke_stuffed"
	pred_plush = TRUE
	prey_plush = TRUE
	can_eat_food = TRUE
