// overriden from `code/datums/id_trim/_id_trim.dm`
/datum/id_trim
	trim_icon = 'modular_gs/icons/obj/card.dmi'

/datum/id_trim/away/gato_fastfood
	assignment = "GATO Fast Food Worker"
	access = list(ACCESS_FACTION_PUBLIC, ACCESS_TELEPORTER, ACCESS_MAINT_TUNNELS)
	big_pointer = TRUE

/datum/id_trim/away/gato_fastfood/manager
	assignment = "GATO Fast Food Manager"
