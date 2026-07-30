/mob/living/carbon/Initialize(mapload)
	. = ..()
	blueberry_inflate_loop = new(src, FALSE)

/mob/living/carbon/Destroy()
	QDEL_NULL(blueberry_inflate_loop)
	return ..()
