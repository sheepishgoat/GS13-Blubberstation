// ### ENGINEERING ###
// can you tell that I'm biased towards a certain department?
/obj/item/clothing/under/color/dual_tone/engineering
	name = "Engineering dual tone jumpsuit (Modular)"
	desc = "Dual tone, high visibility orange jumpsuit worn by engineers. It has minor radiation shielding."
	greyscale_colors = "#FFDD00#FF7F00"
	armor_type = /datum/armor/clothing_under/rank_engineering
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/dual_tone/engineering/chief
	name = "Chief Engineers dual tone jumpsuit (Modular)"
	desc = "Dual tone, gray jumpsuit given to those engineers insane enough to achieve the rank of \"Chief Engineer\". It has minor radiation shielding."
	greyscale_colors = "#dfdfdf#FFCC33"
	armor_type = /datum/armor/clothing_under/engineering_chief_engineer

/obj/item/clothing/under/color/dual_tone/engineering/atmos
	name = "Atmospherics dual tone jumpsuit (Modular)"
	desc = "Dual tone, high visibility yellow blue jumpsuit worn by Atmospherics Technicians. It has minor fire protective plating."
	greyscale_colors = "#FFe000#00A9FF"

/obj/item/clothing/under/color/dual_tone/engineering/tcomms
	name = "Telecomms specialists dual tone jumpsuit (Modular)"
	desc = "Dual tone, high visibility yellow blue jumpsuit worn by the telecomms specialists. Don't mistake with atmos techs!"
	greyscale_colors = "#FFDD00#0048ff"

// ### MEDBAY ###

/obj/item/clothing/under/color/dual_tone/medbay
	name = "Doctors dual tone jumpsuit (Modular)"
	desc = "Dual tone, white-blue uniform worn by medical personnel. Provides minor protection against biohazards."
	greyscale_colors = "#FFFFFF#5A96BB"
	armor_type = /datum/armor/clothing_under/rank_medical
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/dual_tone/medbay/chief_medical_officer
	name = "Chief Medical Officers dual tone jumpsuit (Modular)"
	desc = "Dual tone, white jumpsuit worn by those with the experience to be \"Chief Medical Officer\". Provides minor biohazard shielding."
	greyscale_colors = "#FFFFFF#3366FF"

/obj/item/clothing/under/color/dual_tone/medbay/chemist
	name = "Chemists dual tone jumpsuit (Modular)"
	desc = "Dual tone, white-orange uniform worn by chemists. Provides minor protection against acids."
	greyscale_colors = "#FFFFFF#FF8800"
	armor_type = /datum/armor/clothing_under/medical_chemist

/obj/item/clothing/under/color/dual_tone/medbay/geneticist
	name = "Geneticists dual tone jumpsuit (Modular)"
	desc = "Dual tone, white-blue jumpsuit worn by geneticists. Provides minor biohazard shielding."
	greyscale_colors = "#FFFFFF#0097CA"

/obj/item/clothing/under/color/dual_tone/medbay/virologist
	name = "Virologists dual tone jumpsuit (Modular)"
	desc = "Dual tone, white-green jumpsuit worn by virologists. Provides minor biohazard shielding."
	greyscale_colors = "#FFFFFF#339900"

/obj/item/clothing/under/color/dual_tone/medbay/paramedic
	name = "Paramedics dual tone jumpsuit (Modular)"
	desc = "Dual tone, dark-blue jumpsuit with white stripes worn by paramedics. Provides minor biohazard shielding."
	greyscale_colors = "#364660#FFFFFF"

/obj/item/clothing/under/color/dual_tone/medbay/psychologist
	name = "Psychologists dual tone jumpsuit (Modular)"
	desc = "Dual tone, black jumpsuit with white stripes worn by psychologists."
	greyscale_colors = "#202020#FFFFFF"
	armor_type = /datum/armor/clothing_under

// ### SCIENCE ###

/obj/item/clothing/under/color/dual_tone/science
	name = "Scientists dual tone jumpsuit (Modular)"
	desc = "Dual tone, white-purple labcoat worn by the stations eggheads. Has shielding providing minor protection against explosions."
	greyscale_colors = "#FFFFFF#AA24EA"
	armor_type = /datum/armor/clothing_under/science
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/dual_tone/science/research_director
	name = "Research Director dual tone jumpsuit (Modular)"
	desc = "Dual tone labcoat worn by those with the know-how to achieve the position of \"Research Director\". Has shielding providing minor protection against explosions and acids."
	greyscale_colors = "#AA24EA#FFFFFF"
	armor_type = /datum/armor/clothing_under/rnd_research_director

/obj/item/clothing/under/color/dual_tone/science/roboticist
	name = "Roboticists dual tone jumpsuit (Modular)"
	desc = "Dual tone, black suit worn by roboticists."
	greyscale_colors = "#363636#8B2400"

// ### CARGO ###

/obj/item/clothing/under/color/dual_tone/cargo
	name = "Cargo technicians dual tone jumpsuit (Modular)"
	desc = "Dual tone, yellow-gray jumpsuit worn by cargo techs. Comfy and with big pockets!"
	greyscale_colors = "#D6B328#C0C0C0"
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/dual_tone/cargo/quartermaster
	name = "Quartermasters dual tone jumpsuit (Modular)"
	desc = "Dual tone, yellow-gray jumpsuit by the Quartermaster. It's specially designed to prevent back injuries caused by pushing paper."
	greyscale_colors = "#BB9042#C0C0C0"

/obj/item/clothing/under/color/dual_tone/cargo/miner
	name = "Shaft miners dual tone jumpsuit (Modular)"
	desc = "Dual tone, greenish-purple jumpsuit worn by miners. Provides good fire protection."
	greyscale_colors = "#717261#8A5AE1"
	armor_type = /datum/armor/clothing_under/cargo_miner

/obj/item/clothing/under/color/dual_tone/cargo/bitrunner
	name = "Bitrunners dual tone jumpsuit (Modular)"
	desc = "Dual tone, black brown jumpsuit worn by the laziest person in the cargo department. With how long you sit in that pod, it's obvious why the outfit needs to be stretchy..."
	greyscale_colors = "#242424#432100"

// ### SECURITY ###

/obj/item/clothing/under/color/dual_tone/security
	name = "Security officer's dual tone jumpsuit (Modular)"
	desc = "Dual tone, dark blue tactical jumpsuit worn by security officers. Comes with plating meant for pretection against melee attacks."
	greyscale_colors = "#00386e#222222"
	strip_delay = 50
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	armor_type = /datum/armor/clothing_under/rank_security
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/dual_tone/security/red
	name = "Red Security officer's dual tone jumpsuit (Modular)"
	desc = "Dual tone, red tactical jumpsuit reminding you of the good old days. Comes with plating meant for pretection against melee attacks."
	greyscale_colors = "#C12D30#545350"

/obj/item/clothing/under/color/dual_tone/security/medic
	name = "Security medic dual tone jumpsuit (Modular)"
	desc = "Dual tone, deep red and white jumpsuit worn by the security medic."
	greyscale_colors = "#910000#c7c7c7"

/obj/item/clothing/under/color/dual_tone/security/head_of_security
	name = "Head of Security's dual tone jumpsuit (Modular)"
	desc = "Dual tone, dark blue tactical jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	greyscale_colors = "#002243#FFDD00"
	armor_type = /datum/armor/clothing_under/security_head_of_security
	strip_delay = 60

/obj/item/clothing/under/color/dual_tone/security/warden
	name = "Wardens dual tone jumpsuit (Modular)"
	desc = "Dual tone, red tactical jumpsuit worn by the warden."
	greyscale_colors = "#002243#D0D0D0"

/obj/item/clothing/under/color/dual_tone/security/detective
	name = "Detective dual tone jumpsuit (Modular)"
	desc = "It was a dual tone, white jumpsuit like any other... but I could tell there was something wrong. It's brown stripe was stretched across their huge belly, indicating that this wasn't a mere bedsheet, but rather, something worn by this stations loose cannon..."
	greyscale_colors = "#FFFFFF#AB731C"

/obj/item/clothing/under/color/dual_tone/security/engineering
	name = "Engineering guard dual tone jumpsuit (Modular)"
	desc = "Dual tone, high-vis orange-white jumpsuit worn by the poor seccie assigned to the engineering department."
	greyscale_colors = "#FF7F00#dddddd"

/obj/item/clothing/under/color/dual_tone/security/medbay
	name = "Orderly dual tone jumpsuit (Modular)"
	desc = "Dual tone, white-light blue jumpsuit worn by the one person in medbay that takes the hippocratic oath as a suggestion."
	greyscale_colors = "#FFFFFF#77cdff"

/obj/item/clothing/under/color/dual_tone/security/science
	name = "science guard dual tone jumpsuit (Modular)"
	desc = "Dual tone, purple white jumpsuit worn by the scientists guard."
	greyscale_colors = "#dddddd#390039"

/obj/item/clothing/under/color/dual_tone/security/cargo
	name = "Customs agent dual tone jumpsuit (Modular)"
	desc = "Dual tone, brown black jumpsuit worn by the cargo guard."
	greyscale_colors = "#b7793d#202020"

/obj/item/clothing/under/color/dual_tone/security/service
	name = "Bouncers dual tone jumpsuit (Modular)"
	desc = "Dual tone, black blue jumpsuit worn by the person upholding the order at parties."
	greyscale_colors = "#171717#4c99ff"

// ### SERVICE ###

/obj/item/clothing/under/color/dual_tone/service
	name = "Service dual tone jumpsuit (Modular)"
	desc = "You shouldn't be seeing this!"
	flags_1 = 0		// make it's children non-recolorable

/obj/item/clothing/under/color/dual_tone/service/head_of_personnel
	name = "Head of Personnel dual tone jumpsuit (Modular)"
	desc = "Dual tone, navy colored jumpsuit with red stripes, worn by the defender of Ian, the \"Head of Personnel\"."
	greyscale_colors = "#006086#B00000"

/obj/item/clothing/under/color/dual_tone/service/bartender
	name = "Bartenders dual tone jumpsuit (Modular)"
	desc = "Dual tone, white jumpsuit with black stripes. Classical bartender look."
	greyscale_colors = "#FFFFFF#313131"

/obj/item/clothing/under/color/dual_tone/service/chaplain
	name = "Chaplains dual tone jumpsuit (Modular)"
	desc = "Dual tone, black jumpsuit with golden stripes. Deus Vult."
	greyscale_colors = "#363636#FFDD00"

/obj/item/clothing/under/color/dual_tone/service/chef
	name = "Chefs dual tone jumpsuit (Modular)"
	desc = "Dual tone, but pretty much just white, jumpsuit used by the chef."
	greyscale_colors = "#FFFFFF#C0C0C0"

/obj/item/clothing/under/color/dual_tone/service/hydroponics
	name = "Botanists dual tone jumpsuit (Modular)"
	desc = "Dual tone, green jumpsuit with blue stripes. Provides minor protection against plant-related hazards."
	greyscale_colors = "#6AD427#3164FF"

/obj/item/clothing/under/color/dual_tone/service/janitor
	name = "Janitors dual tone jumpsuit (Modular)"
	desc = "Dual tone, grey jumpsuit with purple stripes. Used by the station's cleankeeper, it has minor protection from biohazards."
	greyscale_colors = "#C0C0C0#A747C0"
	armor_type = /datum/armor/clothing_under/civilian_janitor

/obj/item/clothing/under/color/dual_tone/service/lawyer
	name = "Lawyers dual tone jumpsuit (Modular)"
	desc = "Dual tone, black jumpsuit with blue stripes. Worn by lawyers."
	greyscale_colors = "#303030#FFFFFF"

/obj/item/clothing/under/color/dual_tone/service/curator
	name = "Curators dual tone jumpsuit (Modular)"
	desc = "Dual tone, red jumpsuit with white stripes. Worn by curators."
	greyscale_colors = "#911719#FFFFFF"

/obj/item/clothing/under/color/dual_tone/service/barber
	name = "Barbers dual tone jumpsuit (Modular)"
	desc = "Fancy looking, dual tone pink and white jumpsuit."
	greyscale_colors = "#ff99d1#eeeeee"

// ### SPECIAL ###

/obj/item/clothing/under/color/dual_tone/command
	name = "Command dual tone jumpsuit (Modular)"
	desc = "You shouldn't be seeing this!"
	flags_1 = 0		// make it's children non-recolorable

/obj/item/clothing/under/color/dual_tone/command/captain
	name = "Captains dual tone jumpsuit (Modular)"
	desc = "Dual tone, deep blue jumpsuit with gold markings. Worn by the most distinguished crew member aboard, the \"Captain\"."
	greyscale_colors = "#004B8F#E1C709"
	armor_type = /datum/armor/clothing_under/rank_captain
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/color/dual_tone/command/blueshield
	name = "Blueshields dual tone jumpsuit (Modular)"
	desc = "Dual tone, dark blue jumpsuit with white markings. Worn by the commands prime bodyguard."
	greyscale_colors = "#002243#eeeeee"
	strip_delay = 50
	armor_type = /datum/armor/clothing_under/rank_blueshield
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/color/dual_tone/prisonner
	name = "Prisoners dual tone jumpsuit (Modular)"
	desc = "Dual tone, orange jumpsuit with black markings. Worn by the scum of the station."
	greyscale_colors = "#FF7F00#202020"
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/dual_tone/centcom
	name = "CentComs Officer dual tone jumpsuit (Modular)"
	desc = "Dual tone, black jumpsuit with deep purple stripes. Worn by representatives of GATO corporation."
	greyscale_colors = "#1a1a20#ee2cb4"
	flags_1 = 0		// make it non-recolorable

/obj/item/clothing/under/color/dual_tone/centcom/civilian
	name = "GATO flavored dual tone jumpsuit (Modular)"
	desc = "Dual tone, black jumpsuit with deep purple stripes. Worn by people obsessed with the kitty meow meow corporation."
	greyscale_colors = "#1a1a20#ee2cb4"
	flags_1 = 0		// make it non-recolorable
