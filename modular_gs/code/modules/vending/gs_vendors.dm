
//GATO - meal vendor
/obj/machinery/vending/mealdor
	name = "Meal Vendor"
	desc = "The vending machine used by starving people. Looks like they've changed the shell, it looks cuter."
	icon = 'modular_gs/icons/obj/vending.dmi'
	icon_state = "mealdor"
	product_slogans = "Are you hungry? Eat some of my food!;Be sure to eat one of our tasty treats!;Was that your stomach? Go ahead, get some food!"
	vend_reply = "Enjoy your meal."
	free = TRUE
	allow_custom = TRUE
	products = list(

	            /obj/item/food/pizza/margherita = 10,
	            /obj/item/food/butterdog = 6,
				/obj/item/food/fries = 10,
				/obj/item/food/donut = 10,
				/obj/item/food/burrito = 8,
	            /obj/item/food/pie/plump_pie = 4,
				/obj/item/food/cake/pound_cake = 10,
				/obj/item/food/cake/cheese = 6,
				/obj/item/food/cake/pumpkinspice = 3,
				/obj/item/food/vendor_tray_meal/burger = 10,
				/obj/item/food/vendor_tray_meal/chicken_sandwich = 10,
				/obj/item/food/vendor_tray_meal = 10,
				/obj/item/food/vendor_tray_meal/ramen = 10,
				/obj/item/food/vendor_tray_meal/baked_rice = 10
				)
	contraband = list(
				/obj/item/clothing/head/utility/chefhat = 5,
				/obj/item/food/cookie = 10,
				/obj/item/food/salad/fruit = 15,
	            /obj/item/food/dough = 10
				///obj/item/food/blueberry_gum = 5
				)
	premium = list(
				///obj/item/reagent_containers/cup/soda_cans/air = 3,
				/obj/item/food/donut/chaos = 3,
				/obj/item/food/burger/greaseburger = 6,
				///obj/item/clothing/mask/cowmask/gag = 2,
				///obj/item/clothing/mask/pig/gag = 2
				)

	refill_canister = /obj/item/vending_refill/mealdor


//GATO COLA - for drinks
/obj/machinery/vending/gato
	name = "GATO Vending Machine"
	desc = "A GATO branded cola machine, a cute little cat is plastered onto it."
	icon = 'modular_gs/icons/obj/vending.dmi'
	icon_state = "cola_black"
	product_slogans = "Meow~, time for some cola!"
	vend_reply = "Meow~ Meow~"
	products = list(
	            /obj/item/reagent_containers/cup/soda_cans/cola = 10,
	            /obj/item/reagent_containers/cup/soda_cans/dr_gibb = 10,
				/obj/item/reagent_containers/cup/soda_cans/starkist = 10,
				/obj/item/reagent_containers/cup/soda_cans/space_up = 10,
				/obj/item/reagent_containers/cup/soda_cans/pwr_game = 10,
				/obj/item/reagent_containers/cup/bigbottle/starkist = 6,
				/obj/item/reagent_containers/cup/bigbottle/cola = 6,
				/obj/item/reagent_containers/cup/bigbottle/spaceup = 6,
	            /obj/item/reagent_containers/cup/glass/bottle/orangejuice = 10,
	            /obj/item/reagent_containers/cup/glass/bottle/pineapplejuice = 10,
	            /obj/item/reagent_containers/cup/glass/bottle/strawberryjuice = 10,
				)
	contraband = list(
				/obj/item/organ/ears/cat = 2,
				)
	premium = list(
				/obj/item/reagent_containers/cup/soda_cans/air = 20,
				/obj/item/reagent_containers/cup/soda_cans/fizzwiz = 5,
				/obj/item/reagent_containers/cup/soda_cans/soothseltz = 8,
				/obj/item/reagent_containers/cup/bigbottle/fizz = 3,
				)

	refill_canister = /obj/item/vending_refill/mealdor

/obj/item/vending_refill/mealdor
	machine_name = "Meal Vendor Refill"
	icon = 'modular_gs/icons/obj/vending_restock.dmi'
	icon_state = "refill_mealdor"

/obj/machinery/vending
	/// Are the products inside free?
	var/free = FALSE

//general purpose fatty stuff - admin use only!
/obj/machinery/vending/fatty_items
	name = "Fatwankus Vendor"
	desc = "A vendor packed to the brim with all sorts of waistline-widening tools and things."
	icon = 'modular_gs/icons/obj/vending.dmi'
	icon_state = "fattywank"
	product_slogans = "Fatass."
	vend_reply = "Pervert."
	products = list(
	            /obj/item/reagent_containers/cup/beaker/galbanic = 99,
				/obj/item/reagent_containers/cup/beaker/lipoifier = 99,
				/obj/item/gun/energy/fatoray/cannon = 99,
				/obj/item/gun/energy/fatoray = 99,
				/obj/item/metal_food/mburger_calorite = 99,
				)

	refill_canister = /obj/item/vending_refill/mealdor


//gato merch vendor
/obj/machinery/vending/gato_merch
	name = "GATO Merch Vendor"
	desc = "The gaudy kitsche color of pink practically blinds you."
	icon = 'modular_gs/icons/obj/vending.dmi'
	icon_state = "gatomerch"
	product_slogans = "Mrrau~ You'd look good in pink!"
	vend_reply = "Lovely choice~"
	products = list(
				/obj/item/toy/plush/gs13/gatito = 6,
				/obj/item/soap/gato = 6,
				/obj/item/book/manual/gato_spacelaw = 6,
				/obj/item/book/manual/fatty_chems = 6,
				/obj/item/book/lorebooks/welcome_to_gato = 6,
				/obj/item/storage/fancy/cigarettes/gatito = 8,
				/obj/item/sign/flag/gato = 10,
				/obj/item/toy/cards/deck/gato = 5,
				/obj/item/bedsheet/gato = 3,
				/obj/item/clothing/under/color/dual_tone/centcom/civilian = 5,
				)

	refill_canister = /obj/item/vending_refill/gato_merch

/obj/item/vending_refill/gato_merch
	machine_name = "Gato Merch Vendor Refill"
	icon = 'modular_gs/icons/obj/vending_restock.dmi'
	icon_state = "refill_gato"
