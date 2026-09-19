/obj/item/melee/baton/stunsword/fattening
	name = "fattening stunsword"
	desc = "functions the same as it's standard counterpart, but fattens targets when used aggressively."
	force = 20
	damtype = FAT

/obj/item/melee/baton/fattening
	name = "fattening stunbaton"
	desc = "functions the same as it's standard counterpart, but fattens targets when used aggressively."
	force = 20
	damtype = FAT

/obj/item/melee/curator_whip/fattening
	name = "Calorite Whip"
	desc = "The whip seems to glisten with an orange gleam inbetween its threads."
	icon = 'modular_gs/icons/obj/weapons/fat_weapons.dmi'
	icon_state = "calorite_whip"
	damtype = FAT
	force = 25

/obj/item/melee/curator_whip/permafattening
	name = "Galbanic Whip"
	desc = "The whip's threads glisten with a sinister red gleam, infused with the finest powers of perma-fattening."
	icon = 'modular_gs/icons/obj/weapons/fat_weapons.dmi'
	icon_state = "galbanic_whip"
	damtype = PERMA_FAT
	force = 25

/obj/item/gavelhammer/fattening
	name = "Calorite Hammer"
	desc = "Some madman managed to create a weapon out of calorite... Luckily, it has a rubber handle for you to wield."
	icon = 'modular_gs/icons/obj/weapons/fat_weapons.dmi'
	// lefthand_file = 'modular_gs/icons/mob/inhands/melee_lefthand_64.dmi'	//files are in, but the sprites aren't aligned well at the time of writing this
	// righthand_file = 'modular_gs/icons/mob/inhands/melee_righthand_64.dmi'
	icon_state = "calorite_hammer"
	damtype = FAT
	throwforce = 25
	force = 30

/obj/item/gavelhammer/permafattening
	name = "Galbanic Hammer"
	desc = "Destroyer of waistlines. It is infused with the finest powers of long-term fattening."
	icon = 'modular_gs/icons/obj/weapons/fat_weapons.dmi'
	icon_state = "galbanic_hammer"
	damtype = PERMA_FAT
	throwforce = 25
	force = 30

//i'm ngl these don't work :/ (putting in the sprites just in case)
/obj/item/gavelhammer/loss
	name = "Lipolicidic Mace"
	desc = "Harmless. Beneficial, in fact: this mace might be able to slim people that it hits."
	icon = 'modular_gs/icons/obj/weapons/fat_weapons.dmi'
	icon_state = "lipolicide_mace"
	damtype = FAT
	throwforce = 0
	force = 0

/obj/item/gavelhammer/permaloss
	name = "Macerinic Mace"
	desc = "Get it? Mace-rinic? Haha."
	icon = 'modular_gs/icons/obj/weapons/fat_weapons.dmi'
	icon_state = "macarenic_mace"
	damtype = PERMA_FAT
	throwforce = 0
	force = 0
