//GS13 Edit - GS13 xenoarch rewards here
/obj/machinery/xenoarch/researcher/proc/gato_rewards(mob/user)
	var/turf/src_turf = get_turf(src)
	var/choice = tgui_input_list(user, "Choose which reward you would like!", "Reward Choice", list("Seeds (15)",
																									"Book of fattening (200)"))
	if(!choice)
		return

	//This is for future compatibility by adding more choices to this TGUI menu,
	///please reference obj/machinery/xenoarch/researcher/attack_hand_secondary on how to implement additional choices for this menu
	switch(choice)
		if("Seeds (15)")
			seed_rewards(user)

		if("Book of fattening (200)")
			if(current_research < 200)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 200
			new /obj/item/book/granter/action/spell/gain(src_turf)

//GS13 Edit - GS13 xenoarch seed rewards here
/obj/machinery/xenoarch/researcher/proc/seed_rewards(mob/user)
	var/turf/src_turf = get_turf(src)
	var/choice = tgui_input_list(user, "Choose which reward you would like!", "Reward Choice", list("Strange seed",
																									"Adipolipus",
																									"Amauri",
																									"Gelthi",
																									"Jurlmah",
																									"Nofruit",
																									"Shand",
																									"Surik",
																									"Telriis",
																									"Thaadra",
																									"Vale",
																									"Vaporsac"))
	if(!choice)
		return

	switch(choice)
		if("Strange seed")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/random(src_turf)
		if("Adipolipus")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/lipoplant(src_turf)
		if("Amauri")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/amauri(src_turf)
		if("Gelthi")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/gelthi(src_turf)
		if("Jurlmah")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/jurlmah(src_turf)
		if("Nofruit")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/nofruit(src_turf)
		if("Shand")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/shand(src_turf)
		if("Surik")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/surik(src_turf)
		if("Telriis")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/telriis(src_turf)
		if("Thaadra")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/thaadra(src_turf)
		if("Vale")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/vale(src_turf)
		if("Vaporsac")
			if(current_research < 15)
				balloon_alert(user, "insufficient research!")
				return
			current_research -= 15
			new /obj/item/seeds/vaporsac(src_turf)
