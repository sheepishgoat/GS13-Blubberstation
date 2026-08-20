#define EVENT_PERK_JSON_FOLDER	"data/event_perks/"

#define CAN_REDEEM TRUE
#define CAN_NOT_REDEEM FALSE

GLOBAL_LIST_EMPTY_TYPED(event_perk_instances, /datum/event_perk)
GLOBAL_DATUM(event_perk_tgui_holder, /datum/event_perk)

/datum/event_perk
	// abstract_type = /datum/event_perk
	var/name = ""
	var/description = ""
	/// list of items delivered to the player, and their amount
	var/list/items = list()
	/// list of ckeys that can redeem this particular perk. also stores if any particular ckey can redeem a perk this round - TRUE means it can be redeemed, FALSE means it can't
	var/list/ckeys = list()
	/// date when the perk expires. String in a DDMMYYYY format
	var/expiry_date = 0
	/// string used to send data to the TGUI. Set automatically, DON'T MODIFY IT
	var/expiry_date_string = ""
	///has the perk expired yet
	var/expired = FALSE

/datum/event_perk/proc/redeem()
	ckeys[usr.ckey] = CAN_NOT_REDEEM
	for (var/item in items)
		var/amount = items[item]
		for(var/i in 1 to amount)
			var/obj/item/selected_item = item
			new selected_item (usr.drop_location())

/datum/event_perk/proc/check_expiry_date(day, month, year)
	var/perk_day = text2num(copytext(expiry_date, 1, 3))
	var/perk_month = text2num(copytext(expiry_date, 3, 5))
	var/perk_year = text2num(copytext(expiry_date, 5, 9))
	expiry_date_string = "[perk_day].[perk_month].[perk_year]"

	if (perk_year > year)
		expired = FALSE
		return
	if (perk_year < year)
		expired = TRUE
		return
	
	if (perk_month > month)
		expired = FALSE
		return
	if (perk_month < month)
		expired = TRUE
		return
	
	if (perk_day > day)
		expired = FALSE
		return
	if (perk_day < day)
		expired = TRUE
		return
	
	expired = TRUE

/datum/event_perk/proc/load_from_json(file_path)
	if(!fexists(file_path))
		message_admins("Attempted to load an event perk from json and the file does not exist")
		qdel(src)
		return FALSE
	
	var/datum/json_savefile/json_file = new /datum/json_savefile(file_path)

	var/list/_items = list()

	name = json_file.get_entry("name")
	description = json_file.get_entry("description")
	_items = json_file.get_entry("items")
	ckeys = json_file.get_entry("ckeys")
	expiry_date = json_file.get_entry("expiry_date")

	for (var/item in _items)
		var/item_path_string = item
		var/item_path = text2path(item_path_string)
		var/item_amount = _items[item]
		src.items[item_path] = item_amount

	for (var/ckey in ckeys)
		ckeys[ckey] = CAN_REDEEM

	qdel(json_file)
	return TRUE

/datum/event_perk/proc/save_to_json(directory_path = EVENT_PERK_JSON_FOLDER)
	var/file_name = name
	var/file_path = directory_path + file_name + ".json"

	var/datum/json_savefile/json_file = new /datum/json_savefile(file_path)

	json_file.set_entry("name", name)
	json_file.set_entry("description", description)
	json_file.set_entry("items", items)
	json_file.set_entry("ckeys", ckeys)
	json_file.set_entry("expiry_date", expiry_date)

	json_file.save()
	qdel(json_file)

/datum/event_perk/proc/remove_json(directory_path = EVENT_PERK_JSON_FOLDER)
	var/file_name = name
	var/file_path = directory_path + file_name + ".json"

	if(!fexists(file_path))
		return
	
	fdel(file_path)

/datum/event_perk/proc/copy(datum/event_perk/perk)
	src.name = perk.name
	src.description = perk.description
	src.expiry_date = perk.expiry_date
	src.items = perk.items.Copy()
	src.ckeys = perk.ckeys.Copy()

	var/perk_day = text2num(copytext(expiry_date, 1, 3))
	var/perk_month = text2num(copytext(expiry_date, 3, 5))
	var/perk_year = text2num(copytext(expiry_date, 5, 9))
	expiry_date_string = "[perk_day].[perk_month].[perk_year]"

/datum/event_perk/ui_state(mob/user)
	return GLOB.always_state

/datum/event_perk/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EventPerkRedeemer")
		ui.open()

/datum/event_perk/ui_static_data(mob/user)
	var/list/data = list()
	data["available_perks"] = list()
	data["admin_mode"] = FALSE
	var/ckey = user.ckey

	for (var/i = 1, i <= GLOB.event_perk_instances.len, i++)
		var/datum/event_perk/selected_perk = GLOB.event_perk_instances[i]
		if (selected_perk.expired)
			continue
		
		if (selected_perk.ckeys.Find(ckey))
			var/list/perk_data = list(
				"name" = selected_perk.name,
				"description" = selected_perk.description,
				"items" = list(),
				"ckeys" = list(),
				"expiry_date" = selected_perk.expiry_date_string,
				"available" = selected_perk.ckeys[ckey],
				)
			
			for (var/item in selected_perk.items)
				var/obj/item/current_item = item
				var/item_name = current_item::name
				var/item_amount = selected_perk.items[item]
				var/list/list_entry = list(
					"name" = item_name, 
					"amount" = item_amount
					)
				UNTYPED_LIST_ADD(perk_data["items"], list_entry)

			// perk_data["items"] = copytext(perk_data["items"], 1, length(perk_data["items"]) - 1)
			UNTYPED_LIST_ADD(data["available_perks"], perk_data)

	return data

/datum/event_perk/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return .

	switch(action)
		if ("redeem_perk")
			var/name = params["name"]
			for (var/i = 1, i <= GLOB.event_perk_instances.len, i++)
				var/datum/event_perk/perk = GLOB.event_perk_instances[i]
				if (perk.name == name)
					perk.redeem()

	update_static_data(usr)

/proc/populate_event_perks()
	GLOB.event_perk_tgui_holder = new /datum/event_perk
	for (var/perk in subtypesof(/datum/event_perk))
		GLOB.event_perk_instances.Add(new perk)
	
	populate_event_perk_jsons()

	var/date_string = time2text(world.realtime, "DDMMYYYY")
	var/day = text2num(copytext(date_string, 1, 3))
	var/month = text2num(copytext(date_string, 3, 5))
	var/year = text2num(copytext(date_string, 5, 9))

	for (var/i = 1, i <= GLOB.event_perk_instances.len, i++)
		GLOB.event_perk_instances[i].check_expiry_date(day, month, year)

/proc/populate_event_perk_jsons()
	var/directory = EVENT_PERK_JSON_FOLDER
	for(var/file in flist(directory))
		var/file_path = directory + file
		if (!findlasttext(file_path, ".json"))
			continue
		
		var/datum/event_perk/new_perk = new()
		if (new_perk.load_from_json(file_path))
			GLOB.event_perk_instances.Add(new_perk)
		else 
			message_admins("Error loading event perk from file: '[file_path]'. Inform coders. And provide them with plenty of info.")

GAME_VERB_DESC(/mob/living, redeem_event_perk, "Redeem event perk", "Redeem an event perk for an event you participated in.", "OOC")
	GLOB.event_perk_tgui_holder.ui_interact(src)

// -----------------------ADMIN SHIT--------------------------------

/datum/admins
	var/datum/event_perk_maker/event_perk_maker
	var/datum/event_perk_manager/event_perk_manager

ADMIN_VERB(event_perk_maker, R_ADMIN, "Event Perk Maker", "Create a new Event Perk (TGUI).", ADMIN_CATEGORY_EVENTS)
	var/datum/event_perk_maker/panel = user.holder.event_perk_maker
	if(!panel)
		panel = new()
		user.holder.event_perk_maker = panel
		panel.perk_data = new()
	panel.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Event Perk Maker")

/datum/event_perk_maker
	var/datum/event_perk/perk_data

/datum/event_perk_maker/proc/create_perk(name, description, expiry_date)
	var/datum/event_perk/new_perk = new()

	new_perk.name = name
	new_perk.description = description
	new_perk.items = perk_data.items.Copy()
	new_perk.ckeys = perk_data.ckeys.Copy()
	new_perk.expiry_date = expiry_date

	var/overriden_perk = FALSE
	for (var/datum/event_perk/perk in GLOB.event_perk_instances)
		if (perk.name == new_perk.name)
			overriden_perk = TRUE
			perk.copy(new_perk)
			perk.save_to_json()
	
	if (!overriden_perk)
		GLOB.event_perk_instances.Add(new_perk)
		new_perk.save_to_json()


	var/list/logging_data = list(
		"name" = new_perk.name,
		"description" = new_perk.description,
		"items" = new_perk.items,
		"ckeys" = new_perk.ckeys,
		"expiry_date" = new_perk.expiry_date,
	)

	var/action = overriden_perk ? "overriden" : "created"
	log_admin("[key_name(usr)] has [action] perk [new_perk.name].", logging_data)
	message_admins("[key_name_admin(usr)] has [action] perk [new_perk.name].")

	perk_data.name = ""
	perk_data.description = ""
	perk_data.expiry_date = ""
	perk_data.items.RemoveAll(perk_data.items)
	perk_data.ckeys.RemoveAll(perk_data.ckeys)

	if (overriden_perk)
		qdel(new_perk)

/datum/event_perk_maker/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EventPerkMaker")
		ui.open()

/datum/event_perk_maker/ui_state(mob/user)
	return GLOB.always_state

/datum/event_perk_maker/ui_static_data(mob/user)
	var/list/data = list()
	data["Name"] = perk_data.name
	data["Description"] = perk_data.description
	data["Expiry_date"] = perk_data.expiry_date
	data["items"] = list()
	data["ckeys"] = list()

	for (var/item in perk_data.items)
		var/obj/item/current_item = item
		var/item_name = current_item::name
		var/item_amount = perk_data.items[item]
		var/list/list_entry = list(
			"name" = item_name, 
			"amount" = item_amount
			)
		UNTYPED_LIST_ADD(data["items"], list_entry)

	for (var/ckey in perk_data.ckeys)
		UNTYPED_LIST_ADD(data["ckeys"], ckey)

	return data

/datum/event_perk_maker/ui_close(mob/user)
	. = ..()
	perk_data.name = ""
	perk_data.description = ""
	perk_data.expiry_date = ""
	perk_data.items.RemoveAll(perk_data.items)
	perk_data.ckeys.RemoveAll(perk_data.ckeys)

/datum/event_perk_maker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return .

	switch(action)
		if ("create_perk")
			var/name = params["name"]
			var/description = params["description"]
			var/expiry_date = params["expiry_date"]
			create_perk(name, description, expiry_date)
		if ("add_item")
			var/item = text2path(params["item"])
			var/amount = text2num(params["item_amount"])

			if (isnull(item))
				return
			
			if (isnull(amount))
				amount = 1

			perk_data.items[item] = amount
		if ("add_ckey")
			var/ckey = ckey(params["ckey"])

			if (isnull(ckey))
				return

			perk_data.ckeys[ckey] = CAN_REDEEM
		if ("remove_item")
			var/item_name = params["item"]
			for (var/item in perk_data.items)
				var/atom/current_item = item
				if (current_item::name == item_name)
					perk_data.items.Remove(item)
					break
		if ("remove_ckey")
			var/ckey = params["ckey"]
			perk_data.ckeys.Remove(ckey)

	update_static_data(usr)

/datum/event_perk_manager
	var/datum/event_perk_maker/event_perk_maker

ADMIN_VERB(event_perk_manager, R_ADMIN, "Event Perk Manager", "Create a new Event Perk (TGUI).", ADMIN_CATEGORY_EVENTS)
	var/datum/event_perk_manager/panel = user.holder.event_perk_manager
	if(!panel)
		panel = new()
		if (!user.holder.event_perk_maker)
			user.holder.event_perk_maker = new()
			user.holder.event_perk_maker.perk_data = new()
		panel.event_perk_maker = user.holder.event_perk_maker
		user.holder.event_perk_manager = panel
	panel.ui_interact(user.mob)
	BLACKBOX_LOG_ADMIN_VERB("Event Perk Manager")

/datum/event_perk_manager/Del()
	. = ..()
	event_perk_maker = null

/datum/event_perk_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/event_perk_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EventPerkRedeemer")
		ui.open()

/datum/event_perk_manager/ui_static_data(mob/user)
	var/list/data = list()
	data["available_perks"] = list()
	data["admin_mode"] = TRUE

	for (var/i = 1, i <= GLOB.event_perk_instances.len, i++)
		var/datum/event_perk/selected_perk = GLOB.event_perk_instances[i]
		
		var/list/perk_data = list(
			"name" = selected_perk.name,
			"description" = selected_perk.description,
			"items" = list(),
			"ckeys" = list(),
			"expiry_date" = selected_perk.expiry_date_string,
			"available" = CAN_REDEEM,
			)
		
		for (var/item in selected_perk.items)
			var/obj/item/current_item = item
			var/item_name = current_item::name
			var/item_amount = selected_perk.items[item]
			var/list/list_entry = list(
				"name" = item_name, 
				"amount" = item_amount
				)
			UNTYPED_LIST_ADD(perk_data["items"], list_entry)

		for (var/ckey in selected_perk.ckeys)
			UNTYPED_LIST_ADD(perk_data["ckeys"], ckey)

		// perk_data["items"] = copytext(perk_data["items"], 1, length(perk_data["items"]) - 1)
		UNTYPED_LIST_ADD(data["available_perks"], perk_data)

	return data

/datum/event_perk_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return .

	var/name = params["name"]

	switch(action)
		if ("redeem_perk")
			for (var/i = 1, i <= GLOB.event_perk_instances.len, i++)
				var/datum/event_perk/perk = GLOB.event_perk_instances[i]
				if (perk.name == name)
					perk.redeem()
					break
		if ("delete_perk")
			for (var/i = 1, i <= GLOB.event_perk_instances.len, i++)
				var/datum/event_perk/perk = GLOB.event_perk_instances[i]
				if (perk.name == name)
					perk.remove_json()
					GLOB.event_perk_instances.Cut(i, i+1)
					qdel(perk)
					break
		if ("edit_perk")
			for (var/i = 1, i <= GLOB.event_perk_instances.len, i++)
				var/datum/event_perk/perk = GLOB.event_perk_instances[i]
				if (perk.name == name)
					event_perk_maker.perk_data.copy(perk)
					event_perk_maker.ui_interact(usr, null)
					break

	update_static_data(usr)

#undef EVENT_PERK_JSON_FOLDER
#undef CAN_REDEEM
#undef CAN_NOT_REDEEM
