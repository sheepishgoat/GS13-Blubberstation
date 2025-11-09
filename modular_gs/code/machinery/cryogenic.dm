/obj/machinery/cryopod/tele //lore-friendly cryo thing
	name = "Long-range Central Command teleporter"
	desc = "A special teleporter for sending employees back to Central Command for reassignments, adjustments or simply to end their shift."
	icon = 'modular_gs/icons/obj/machines/gatopod.dmi'
	time_till_despawn = 10 SECONDS
	on_store_message = "has teleported back to Central Command."
	on_store_name = "Teleporter Oversight"

/obj/machinery/cryopod/tele/mouse_drop_receive(mob/living/target, mob/living/user, params)
	if (iscarbon(target))
		var/mob/living/carbon/person = target
		person.save_persistent_fat()
	
	return ..()

/obj/machinery/cryopod
	/// Do we want to inform comms when someone cryos?
	var/alert_comms = TRUE
	var/on_store_message = "has entered the centcomm teleportation pod."
	var/on_store_name = "Telepod Oversight"
