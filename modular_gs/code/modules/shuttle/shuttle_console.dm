//gato food truck shuttle
/obj/machinery/computer/shuttle/caravan/food_truck
	name = "Food Truck Console"
	desc = "Used to control the GATO Food 'Truck'. Obviously, it's not actually a truck."
	circuit = /obj/item/circuitboard/computer/food_truck
	shuttleId = "food_truck"
	possible_destinations = "food_truck_custom;food_truck_home;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/food_truck
	name = "Truck Navigation Computer"
	desc = "Used to designate a precise transit location for the GATO Food 'Truck'."
	shuttleId = "food_truck"
	lock_override = NONE
	shuttlePortId = "food_truck_custom"
	jump_to_ports = list("food_truck_home" = 1, "whiteship_home" = 1)
	view_range = 0
