/obj/machinery/vending/clothing
	gs_product_categories = list(
		list(
			"name" = "Under",
			"icon" = "shirt",
			"products" = list(
				/obj/item/clothing/under/color/grey = 5,
				/obj/item/clothing/under/dual_tone = 5,
				/obj/item/clothing/under/dual_tone/button_up = 5,
				/obj/item/clothing/under/dual_tone/bunny_suit = 5,
				),
			),
	)

/obj/machinery/vending/wardrobe/sec_wardrobe
	gs_product_categories = list(
		list(
			"name" = "Red",
			"icon" = "shield",
			"products" = list(
				/obj/item/clothing/under/color/grey/security = 3,
				/obj/item/clothing/under/dual_tone/security = 3,
				),
			),
	)

/obj/machinery/vending/wardrobe/medi_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/medical = 3,
		/obj/item/clothing/under/dual_tone/medbay = 3,
		/obj/item/clothing/under/dual_tone/medbay/paramedic = 3,
	)
	gs_premium = list(
		/obj/item/clothing/under/dual_tone/medbay/psychologist = 3,
		/obj/item/clothing/under/dual_tone/button_up/psychologist = 3,
	)

/obj/machinery/vending/wardrobe/engi_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/engi = 3,
		/obj/item/clothing/under/dual_tone/engineering = 3,
		/obj/item/clothing/under/dual_tone/engineering/tcomms = 3,
	)

/obj/machinery/vending/wardrobe/atmos_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/engi = 3,
		/obj/item/clothing/under/dual_tone/engineering/atmos = 3,
	)

/obj/machinery/vending/wardrobe/cargo_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/cargo = 3,
		/obj/item/clothing/under/dual_tone/cargo = 3,
		/obj/item/clothing/under/dual_tone/button_up/cargo = 3,
	)
	gs_premium = list(
		/obj/item/clothing/under/dual_tone/cargo/bitrunner = 3,
		/obj/item/clothing/under/dual_tone/cargo/miner = 3,
	)

/obj/machinery/vending/wardrobe/robo_wardrobe
	gs_product_categories = list(
		list(
			"name" = "Clothing",
			"icon" = FA_ICON_SHIRT,
			"products" = list(
				/obj/item/clothing/under/color/grey/science = 3,
				/obj/item/clothing/under/dual_tone/science/roboticist = 3,
				),
			),
	)

/obj/machinery/vending/wardrobe/science_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/science = 3,
		/obj/item/clothing/under/dual_tone/science = 3,
		/obj/item/clothing/under/dual_tone/button_up/science = 3,
	)

/obj/machinery/vending/wardrobe/hydro_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/service = 3,
		/obj/item/clothing/under/dual_tone/service/hydroponics = 3,
	)

/obj/machinery/vending/wardrobe/curator_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/service = 3,
		/obj/item/clothing/under/dual_tone/service/curator = 3,
		/obj/item/clothing/under/dual_tone/button_up/service/curator = 3,
	)

/obj/machinery/vending/wardrobe/bar_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/service = 3,
		/obj/item/clothing/under/dual_tone/service/bartender = 3,
		/obj/item/clothing/under/dual_tone/button_up/service/bartender = 3,
	)

/obj/machinery/vending/wardrobe/chef_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/service = 3,
		/obj/item/clothing/under/dual_tone/service/chef = 3,
		/obj/item/clothing/under/dual_tone/button_up/service/chef = 3,
	)

/obj/machinery/vending/wardrobe/jani_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/service = 3,
		/obj/item/clothing/under/dual_tone/service/janitor = 3,
	)

/obj/machinery/vending/wardrobe/law_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/service = 3,
		/obj/item/clothing/under/dual_tone/service/lawyer = 3,
		/obj/item/clothing/under/dual_tone/medbay/psychologist = 3,
		/obj/item/clothing/under/dual_tone/button_up/service/lawyer = 3,
	)

/obj/machinery/vending/wardrobe/chap_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/service = 3,
		/obj/item/clothing/under/dual_tone/service/chaplain = 3,
		/obj/item/clothing/under/dual_tone/button_up/service/chaplain = 3,
	)

/obj/machinery/vending/wardrobe/chem_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/medical = 3,
		/obj/item/clothing/under/dual_tone/medbay/chemist = 3,
	)

/obj/machinery/vending/wardrobe/gene_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/medical = 3,
		/obj/item/clothing/under/dual_tone/medbay/geneticist = 3,
	)

/obj/machinery/vending/wardrobe/viro_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/medical = 3,
		/obj/item/clothing/under/dual_tone/medbay/virologist = 3,
	)

/obj/machinery/vending/wardrobe/det_wardrobe
	gs_products = list(
		/obj/item/clothing/under/color/grey/security = 3,
		/obj/item/clothing/under/dual_tone/security/detective = 3,
		/obj/item/clothing/under/dual_tone/button_up/security/detective = 3,
	)

/obj/machinery/vending/wardrobe/cent_wardrobe
	gs_products = list(
		/obj/item/clothing/under/dual_tone/centcom = 3,
		/obj/item/clothing/under/dual_tone/button_up/centcom = 3,
	)

/obj/machinery/vending/access/command/proc/build_gs13_access_list(list/access_lists)
	access_lists["[ACCESS_CAPTAIN]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/command/captain = 1,
		/obj/item/clothing/under/dual_tone/button_up/command/captain = 1,
		/obj/item/clothing/under/dual_tone/command/blueshield = 1,
		/obj/item/clothing/under/dual_tone/button_up/command/blueshield = 1,
	)
	access_lists["[ACCESS_HOP]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/service/head_of_personnel = 1,
		/obj/item/clothing/under/dual_tone/button_up/service/head_of_personnel = 1,
	)
	access_lists["[ACCESS_CMO]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/medbay/chief_medical_officer = 1,
		/obj/item/clothing/under/dual_tone/button_up/chief_medical_officer = 1,
	)
	access_lists["[ACCESS_RD]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/science/research_director = 1,
		/obj/item/clothing/under/dual_tone/button_up/science/research_director = 1,
	)
	access_lists["[ACCESS_CE]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/engineering/chief = 1,
		/obj/item/clothing/under/dual_tone/button_up/chief_engineer = 1,
	)
	access_lists["[ACCESS_HOS]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/security/head_of_security = 1,
		/obj/item/clothing/under/dual_tone/button_up/security/head_of_security = 1,
	)
	access_lists["[ACCESS_HOS]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/security/head_of_security = 1,
		/obj/item/clothing/under/dual_tone/button_up/security/head_of_security = 1,
	)
	access_lists["[ACCESS_QM]"] += list(
		/obj/item/clothing/under/color/grey/command = 3,
		/obj/item/clothing/under/dual_tone/cargo/quartermaster = 1,
		/obj/item/clothing/under/dual_tone/button_up/cargo/quartermaster = 1,
	)
