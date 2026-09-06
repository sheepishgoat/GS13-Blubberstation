// make it so you can pay in paystands using departmental accounts
/obj/item/card/id/departmental_budget/can_be_used_in_payment(mob/living/user)
	if(QDELETED(src) || !isliving(user))
		return FALSE

	return TRUE
