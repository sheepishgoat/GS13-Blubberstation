
//persistence feedee - replacement for feeder den
/obj/effect/mob_spawn/ghost_role/human/persistence/feedee
	name = "Syndicate Feedee"
	prompt_name = "a Syndicate feedee"
	you_are_text = "You are a hostage onboard an unknown vessel"
	flavour_text = "Unaware of where you are, all you know is you are a prisoner. The plastitanium should clue you into who your captors are... as for why you're here? You seem like an invaluable research asset in this environment..."
	important_text = "You are not an antagonist. You are still bound to the Roleplay Rules regarding escalation. Syndicate personnel will throw you into lava or plasma outside if you antagonize them. This is a role that allows for expansion / weight gain content as well, however the Syndicate personnel is not obligated to partake in any kink RP."
	outfit = /datum/outfit/persistence/prisoner/feedee
	computer_area = /area/ruin/space/has_grav/bubbers/persistance/sec/prison
	give_exploitables = FALSE

/obj/effect/mob_spawn/ghost_role/human/persistence/syndicate/feeder
	name = "Syndicate Feeder"
	prompt_name = "a Syndicate Feeder"
	you_are_text = "You are a Syndicate Feeder, employed on Persistence after your Feeder Den has been blown up by GATO."
	flavour_text = "The Syndicate managed Persistence mining rig has been deployed into enemy territory to stealthily monitor Nanotrasen assets. Your orders are to maintain the ship's integrity, perform your duties and keep a low profile while maintaining your front as a mining operation."
	important_text = "You are NOT an antagonist and the round does not center the Persistence. You MUST submit an Opfor or Adminhelp for significant interaction with the station and its crew. This is a kink focused role but generally focuses on prisoner interaction."
	outfit = /datum/outfit/persistence/syndicate/brigoff

//gato fast food ghost role
/obj/effect/mob_spawn/ghost_role/human/gato_fastfood
	name = "GATO Fast Food Worker"
	desc = "Through the grease-stained cryopod glass, you can see someone sleeping inside."
	icon = 'modular_gs/icons/obj/machines/gatopod.dmi'
	icon_state = "cryopod"
	prompt_name = "a GATO fast food worker"
	you_are_text = "You are an employee of the local GATO Fast Food Restaurant."
	flavour_text = "You were employed in this establishment to provide an authentic, iconic GATO dining experience."
	important_text = "Take care of your workplace and do not abandon it. You may come aboard the station to advertise. Read up the pamphlet in your pocket for more conduct and tips."
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	outfit = /datum/outfit/gato_fastfood
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/gato_fastfood/manager
	name = "GATO Fast Food Manager"
	prompt_name = "a GATO fast food manager"
	you_are_text = "You are the manager of the local GATO Fast Food Restaurant."
	flavour_text = "You were employed in this establishment as a manager to provide an authentic, iconic GATO dining experience."
	important_text = "Manage your workplace, employees and do not abandon either. You may come aboard the station to advertise. Read up the pamphlet in your pocket for more conduct and tips."
	outfit = /datum/outfit/gato_fastfood/manager

