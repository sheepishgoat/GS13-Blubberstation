
/obj/item/pen/calorite
	name = "calorite pen"
	desc = "A novelty pen with the tip made out of calorite, made to celebrate the success of Nutri-Tech! GATO is not liable for any mishandlings of this novelty item."
	icon = 'modular_gs/icons/obj/caloritepen.dmi'
	icon_state = "caloritepen"
	var/poisoning_per_stab = 0.05
	var/fat_per_stab = 0
	var/permafat_per_stab = 0
	can_click = FALSE

/obj/item/pen/calorite/attack(mob/living/carbon/target, mob/living/user)
	. = ..()

	if(!istype(target))
		return

	target.adjust_calorite_poisoning(poisoning_per_stab) //like a hundred stabs will do 1% of poisoning
	target.adjust_fatness(fat_per_stab) //both of these vars don't do anything in base form, mostly used for the syndie variant
	target.adjust_perma(permafat_per_stab)

/obj/item/pen/calorite/syndicate
	name = "nefarious calorite pen"
	desc = "An EVIL syndicate branded pen. Allegedly the tip is made out of galbanic-infused calorite."
	icon = 'modular_gs/icons/obj/caloritepen.dmi'
	icon_state = "caloritepen"
	poisoning_per_stab = 0.5
	fat_per_stab = 5
	permafat_per_stab = 20
