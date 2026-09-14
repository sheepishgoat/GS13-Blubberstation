// make it so you can pay in paystands using departmental accounts
/obj/item/card/id/departmental_budget/can_be_used_in_payment(mob/living/user)
	if(QDELETED(src) || !isliving(user))
		return FALSE

	return TRUE


//gato fast food ghost role IDs

/obj/item/card/id/advanced/gato_fastfood
	name = "GATO Fast Food Worker Card"
	desc = "A slightly greasy, GATO-colored access card."
	icon_state = "card_centcom"
	icon = 'modular_gs/icons/obj/card.dmi'
	trim = /datum/id_trim/away/gato_fastfood

//the manager card doesn't actually differ from the normal one
//just flavor stuff, maybe sometime we'll put up proper access onto the map
/obj/item/card/id/advanced/gato_fastfood/manager
	name = "GATO Fast Food Manager Card"
	trim = /datum/id_trim/away/gato_fastfood/manager

