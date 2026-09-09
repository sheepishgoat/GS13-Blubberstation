/obj/structure/flora/lollipop
	name = "Lollipop tree"
	desc = "A mere snack for people larger than life."
	icon = 'modular_gs/icons/turf/decals_large_candy.dmi'
	icon_state = "lollipop_tree_blue"
	max_integrity = 80
	density = TRUE
	pixel_x = -16
	layer = FLY_LAYER
	anchored = TRUE
	delete_on_harvest = TRUE
	harvest_amount_low = 10
	harvest_amount_high = 20

/obj/structure/flora/lollipop/get_potential_products()
	return list(/obj/item/food/lollipop/lipo = 1)

/obj/structure/flora/candy
	name = "candy patch"
	desc = "It's a wild patch of candy!"
	icon = 'modular_gs/icons/turf/decals_candy.dmi'
	icon_state = "candy_decal1"
	delete_on_harvest = TRUE

/obj/structure/flora/candy/get_potential_products()
	return LIPO_CANDY

/obj/structure/flora/candy/redwhite
	icon_state = "candy_decal1"

/obj/structure/flora/candy/redwhite2
	icon_state = "candy_decal2"

/obj/structure/flora/candy/redwhite3
	icon_state = "candy_decal3"

/obj/structure/flora/candy/greenwhite1
	icon_state = "candy_decal_g1"

/obj/structure/flora/candy/greenwhite2
	icon_state = "candy_decal_g2"

/obj/structure/flora/candy/bluewhite1
	icon_state = "candy_decal_b1"

/obj/structure/flora/candy/purplewhite1
	icon_state = "candy_decal_p1"

/obj/structure/flora/candy/candylight
	name = "Peppermint Light"
	desc = "A light source that's made out of a peppermint tree."
	icon = 'modular_gs/icons/obj/gslight.dmi'
	icon_state = "candylight"
	max_integrity = 500
	light_color = "#a5cfc5" //testing out my copy cat skills. -Metussi
	light_range = 3
	anchored = 1
	delete_on_harvest = TRUE
