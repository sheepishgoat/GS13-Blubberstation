/obj/structure/statue
    /// Controls whether or not we want to be able to speak through the statue
    var/should_marionette = TRUE

/obj/structure/statue/Initialize(mapload)
    . = ..()
    if(should_marionette)
        AddComponent(/datum/component/marionette)
// Structure base for silverscale tongue
/obj/structure/statue/custom/silverscale
    should_marionette = FALSE
