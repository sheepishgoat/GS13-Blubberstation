/obj/structure/reflector/single/calorite
	name = "calorite reflector"
	desc = "An angled mirror using calorite glass for reflecting laser beams, while also giving them fattening properties."
	density = TRUE
	finished = TRUE
	icon = 'modular_gs/icons/obj/structure/structures.dmi'
	deflector_icon_state = "calorite_reflector"
	buildstacktype = /obj/item/stack/sheet/calorite_glass
	buildstackamount = 5

/obj/structure/reflector/single/calorite/anchored
	anchored = TRUE

/obj/structure/reflector/single/calorite/auto_reflect(obj/projectile/proj, pdir, turf/ploc, pangle)
	var/fat_power_to_add = max(proj.fat_added + 25, proj.fat_added * 1.1)
	fat_power_to_add = min(fat_power_to_add, 5000 + initial(proj.fat_added))
	proj.fat_added = fat_power_to_add
	return ..()