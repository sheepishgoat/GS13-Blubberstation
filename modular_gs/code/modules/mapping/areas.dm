/area/fatlab
	name = "Mysterious Facility"
	icon_state = "centcom"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE

/area/crew_quarters/fitness/sauna
	name = "Saunas"
	icon_state = "dk_yellow"


/area/ruin/space/has_grav/fastfood_main
	name = "GATO Restaurant - Main Area"
	default_gravity = STANDARD_GRAVITY

/area/ruin/space/has_grav/fastfood_employee
	name = "Restaurant Employee Area"
	default_gravity = STANDARD_GRAVITY

/area/ruin/space/has_grav/feedersden
	name = "Unknown Outpost"
	default_gravity = STANDARD_GRAVITY


//lavaland xenoarch areas - seperate multi-Z level
/area/lavaland/underground/xenoarch //this is what we'll use for all of non-outpost areas for xenoarch, as it has no storms
	name = "Xenoarch Caves"
	icon = 'modular_gs/icons/turf/areas.dmi'
	icon_state = "xenogen"
	always_unpowered = FALSE

/area/xenoarch/lavaland
	icon = 'modular_gs/icons/turf/areas.dmi'
	icon_state = "xenogen"
	default_gravity = STANDARD_GRAVITY


//xenoarch main outpost areas
/area/xenoarch/lavaland/arch
	name = "Xenoarchaeology Lab"
	icon_state = "xenolab"

/area/xenoarch/lavaland/bot
	name = "Xenoarchaeology Botany"
	icon_state = "xenobot"

/area/xenoarch/lavaland/eng
	name = "Xenoarchaeology Engineering"
	icon_state = "xenoeng"

/area/xenoarch/lavaland/gen
	name = "Xenoarchaeology Living Quarters"
	icon_state = "xenodorm"

/area/xenoarch/lavaland/sec
	name = "Xenoarchaeology Security"
	icon_state = "xenosec"

/area/xenoarch/lavaland/med
	name = "Xenoarchaeology Medical"
	icon_state = "xenomed"

/area/xenoarch/lavaland/bathroom
	name = "Xenoarchaeology Bathroom"
	icon_state = "xenobath"

/area/xenoarch/lavaland/construction
	name = "Xenoarchaeology Construction"
	icon_state = "xenoconst"

/area/xenoarch/lavaland/foyer
	name = "Xenoarchaeology Foyer"
	icon_state = "xenoarch"

/area/xenoarch/lavaland/gym
	name = "Xenoarchaeology Gym"
	icon_state = "xenogym"

/area/xenoarch/lavaland/library
	name = "Xenoarchaeology Library"
	icon_state = "xenolibrary"

/area/xenoarch/lavaland/maint_east
	name = "Xenoarchaeology East Maintenance"
	icon_state = "mainteast"

/area/xenoarch/lavaland/maint_west
	name = "Xenoarchaeology West Maintenance"
	icon_state = "maintwest"

/area/xenoarch/lavaland/public
	name = "Xenoarchaeology Public Area"
	icon_state = "xenopublic"

/area/xenoarch/lavaland/lowerlevel
	name = "Xenoarchaeology Lower Level Ruins"
	icon_state = "xenoruin"

/area/xenoarch/lavaland/public/powered //used primarily for quantum pads
	name = "Xenoarchaeology Public Area"
	icon_state = "xenobot"
	power_light = TRUE
	power_equip = TRUE
	power_environ = TRUE
	requires_power = FALSE
//xenoarch main outpost areas end

/area/lavaland/underground/xenoarch/calorite_temple
	name = "Calorite Temple"
	icon_state = "caloritetemple"
	power_light = TRUE

/area/lavaland/underground/xenoarch/caloriteresearch
	name = "Research Facility Ruins"
	icon_state = "caloriteresearch"
	power_light = TRUE
	power_equip = TRUE
	power_environ = TRUE
	requires_power = FALSE

/area/lavaland/underground/xenoarch/caloriteresearch/unpowered
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE

/area/lavaland/underground/xenoarch/donut_factory
	name = "GATO Donut Factory"
	icon_state = "donutfactory"

/area/lavaland/underground/xenoarch/candy_outpost
	name = "Candyland Survey Post"
	icon_state = "candyoutpost"

/area/lavaland/underground/xenoarch/candyland
	name = "Candyland"
	icon_state = "candyland"
	power_light = TRUE

//xenoarch areas end


/area/ruin/powered/gluttony
	icon_state = "dk_yellow"

/area/ruin/powered/beach
	icon_state = "dk_yellow"


/area/ruin/unpowered/syndicate_lava_base/engineering
	name = "Syndicate Lavaland Engineering"

/area/ruin/unpowered/syndicate_lava_base/medbay
	name = "Syndicate Lavaland Medbay"

/area/ruin/unpowered/syndicate_lava_base/arrivals
	name = "Syndicate Lavaland Arrivals"

/area/ruin/unpowered/syndicate_lava_base/bar
	name = "Syndicate Lavaland Bar"

/area/ruin/unpowered/syndicate_lava_base/main
	name = "Syndicate Lavaland Primary Hallway"

/area/ruin/unpowered/syndicate_lava_base/cargo
	name = "Syndicate Lavaland Cargo Bay"

/area/ruin/unpowered/syndicate_lava_base/chemistry
	name = "Syndicate Lavaland Chemistry"

/area/ruin/unpowered/syndicate_lava_base/virology
	name = "Syndicate Lavaland Virology"

/area/ruin/unpowered/syndicate_lava_base/testlab
	name = "Syndicate Lavaland Experimentation Lab"

/area/ruin/unpowered/syndicate_lava_base/dormitories
	name = "Syndicate Lavaland Dormitories"

/area/ruin/unpowered/syndicate_lava_base/telecomms
	name = "Syndicate Lavaland Telecommunications"

/area/ruin/unpowered/syndicate_lava_base/circuits
	name = "Syndicate Lavaland Circuit Lab"

/area/ruin/unpowered/syndicate_lava_base/nanites
	name = "Syndicate Lavaland Nanite Lab"

/area/ruin/unpowered/syndicate_lava_base/outdoors //Putting this area down should prevent fauna from spawning nearby
	name = "Syndicate Lavaland Approach"
	icon_state = "red"

/area/station/commons/dorms/lower
	name = "\improper Lower Level Dormitories"

/area/ruin/space/has_grav/speedfucking
	name = "Speed Dating Hotel"
	icon = 'modular_gs/icons/turf/areas.dmi'
	icon_state = "xenogen"
	power_light = TRUE
	power_equip = TRUE
	power_environ = TRUE
	requires_power = FALSE
