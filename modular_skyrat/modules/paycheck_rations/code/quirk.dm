/datum/quirk/item_quirk/ration_system
	name = "Ration Ticket Receiver"
	desc = "Due to some circumstance of your life, you have enrolled in the ration tickets program, \
		which will halve all of your paychecks in exchange for granting you ration tickets, which can be \
		redeemed at a cargo console for food and other items."
	icon = FA_ICON_DONATE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	medical_record_text = "Has enrolled in the ration ticket program."
	value = 0
	hardcore_value = 0

	/// Tracks a linked ration ticket book. If we have one of these, then we'll put tickets in it every payday.
	var/datum/weakref/tracked_ticket_book

	/// Tracks if the last ticket we got was for luxury items, if this is true we get a normal food ticket
	var/last_ticket_luxury = TRUE

/datum/quirk/item_quirk/ration_system/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!human_holder.account_id)
		return
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[human_holder.account_id]"]

	var/obj/new_ticket_book = new /obj/item/storage/ration_ticket_book(get_turf(human_holder))
	give_item_to_holder(
		new_ticket_book,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
	)
	tracked_ticket_book = WEAKREF(new_ticket_book)
	account.payday_modifier -= 0.5
	RegisterSignal(account, COMSIG_ON_BANK_ACCOUNT_PAYOUT, PROC_REF(make_ration_ticket))
	to_chat(client_source.mob, span_notice("You remember to keep close hold of your ticket book, it can't be replaced if lost and all of your ration tickets are placed there!"))

/// Attempts to create a ration ticket book in the card holder's hand, and failing that, the drop location of the card
/datum/quirk/item_quirk/ration_system/proc/make_ration_ticket(datum/bank_account/account)
	SIGNAL_HANDLER
	if(!istype(account))
		return

	if(!(SSeconomy.times_fired % 3 == 0))
		return

	if(!account.bank_cards.len)
		return

	var/obj/item/storage/ration_ticket_book/ticket_book = tracked_ticket_book.resolve()
	if(!ticket_book)
		tracked_ticket_book = null
		return

	var/obj/item/created_ticket
	for(var/obj/card in account.bank_cards)
		// We want to only make one ticket per account per payday
		var/ticket_to_make
		if(!last_ticket_luxury)
			ticket_to_make = /obj/item/paper/paperslip/ration_ticket/luxury
		else
			ticket_to_make = /obj/item/paper/paperslip/ration_ticket
		created_ticket = new ticket_to_make(card)
		last_ticket_luxury = !last_ticket_luxury
		if(!ticket_book.atom_storage.attempt_insert(created_ticket, messages = FALSE))
			qdel(created_ticket)
			account.bank_card_talk("ERROR: Failed to place ration ticket in ticket book, ensure book is not full.")
			break
		account.bank_card_talk("A new [last_ticket_luxury ? "luxury item" : "standard"] ration ticket has been placed in your ticket book.")
		break
