#define BASE_FEEDING_TUBE_REAGENTS list(\
		/datum/reagent/consumable/cream,\
		/datum/reagent/consumable/milk,\
		/datum/reagent/consumable/nutriment,\
	)

// same as breast reagents, except no ERP chems
#define EXPANDED_FEEDING_TUBE_REAGENTS list(\
		/datum/reagent/consumable/alien_honey,\
		/datum/reagent/consumable/pinkmilk,\
		/datum/reagent/consumable/milk/chocolate_milk,\
		/datum/reagent/consumable/lipoifier/weak,\
		/datum/reagent/blueberry_juice,\
		/datum/reagent/consumable/starshine/blue,\
)

#define HACKED_FEEDING_TUBE_REAGENTS list(\
		/datum/reagent/consumable/cream,\
		/datum/reagent/consumable/milk,\
		/datum/reagent/consumable/nutriment,\
		/datum/reagent/consumable/alien_honey,\
		/datum/reagent/consumable/pinkmilk,\
		/datum/reagent/consumable/milk/chocolate_milk,\
		/datum/reagent/consumable/lipoifier/weak,\
		/datum/reagent/blueberry_juice,\
		/datum/reagent/consumable/starshine/blue,\
		/datum/reagent/consumable/lipoifier,\
		/datum/reagent/micro_calorite,\
		/datum/reagent/fermi_fat,\
)

/obj/item/reagent_containers/borghypo/medical/feeding_tube
	icon = 'modular_gs/icons/obj/feeding_tube.dmi'
	icon_state = "borg_tube"
	default_reagent_types = BASE_FEEDING_TUBE_REAGENTS
	expanded_reagent_types = EXPANDED_FEEDING_TUBE_REAGENTS

/obj/item/reagent_containers/borghypo/medical/feeding_tube/hacked
	default_reagent_types = HACKED_FEEDING_TUBE_REAGENTS

#undef BASE_FEEDING_TUBE_REAGENTS
#undef EXPANDED_FEEDING_TUBE_REAGENTS
#undef HACKED_FEEDING_TUBE_REAGENTS
