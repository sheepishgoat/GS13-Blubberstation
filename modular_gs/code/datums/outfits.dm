
//gato restaurant ghost role
/datum/outfit/gato_fastfood
	name = "GATO Fast Food Worker"
	uniform = /obj/item/clothing/under/dual_tone/centcom/civilian
	shoes = /obj/item/clothing/shoes/sneakers/black
	head = /obj/item/clothing/head/soft/black
	belt = /obj/item/modular_computer/pda
	r_pocket = /obj/item/paper/fluff/ruins/fastfood
	id = /obj/item/card/id/advanced/gato_fastfood
	skillchips = list(/obj/item/skillchip/job/chef)
	ears = /obj/item/radio/headset/headset_faction

/datum/outfit/gato_fastfood/post_equip(mob/living/carbon/human/clerk, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = clerk.wear_id
	if(istype(id_card))
		id_card.registered_name = clerk.real_name
		id_card.update_label()
		id_card.update_icon()
	handlebank(clerk)
	return ..()

/datum/outfit/gato_fastfood/manager
	name = "GATO Fast Food Manager"
	uniform = /obj/item/clothing/under/dual_tone/button_up/service/curator
	shoes = /obj/item/clothing/shoes/sneakers/brown
	belt = /obj/item/modular_computer/pda
	r_pocket = /obj/item/paper/fluff/ruins/fastfood
	id = /obj/item/card/id/advanced/gato_fastfood/manager
	neck = /obj/item/clothing/neck/tie/allamerican
	skillchips = list(/obj/item/skillchip/job/chef)
	ears = /obj/item/radio/headset/headset_srv

//syndicate persistence prisoner
/datum/outfit/persistence/prisoner/feedee
	name = "Persistence Syndicate Feedee"
	uniform = /obj/item/clothing/under/dual_tone/prisonner

