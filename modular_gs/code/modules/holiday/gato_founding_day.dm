/// The day GATO (and the GS13 server as a whole) was founded
/datum/holiday/gato
	name = "Birthday of GATO Industrial Complex"
	begin_day = 2
	end_day = 9
	begin_month = AUGUST
	holiday_mail = list(
		/obj/item/toy/plush/gs13/gatito = 25,
		/obj/item/soap/gato = 10,
		/obj/item/book/lorebooks/welcome_to_gato = 15,
		/obj/item/toy/cards/deck/gato = 18,
		/obj/item/sign/flag/gato = 20,
	)
	holiday_colors = list(
		COLOR_THEME_GATO_DARK_PINK,
		COLOR_THEME_GATO_DARK
	)

/datum/holiday/gato/greet()
	return "Happy GATO founding day! Today we celebrate the birthday of GATO corporation, the benevolent benefactor of GS13!"

/datum/holiday/gato/get_station_prefix()
	if (prob(1))
		return "Belchalicious"
	return pick("Kitty", "Pink", "Meow Meow", "Corporate")

/datum/holiday/gato/get_station_name()
	if (prob(1))
		return "Buffet"
	return pick("Cat", "Gatito")
