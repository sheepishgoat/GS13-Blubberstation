/datum/quirk/lisp //Ported from Monkestation.
	name = "Lisp"
	desc = "You have a hard time pronoucing thome letterth. Not recommended for people with lizard tongues, Use the organs menu to swap it out."
	medical_record_text = "Patient has a lisp."
	value = 0
	icon = FA_ICON_GRIN_TONGUE

/datum/quirk/lisp/add()
	RegisterSignal(quirk_holder, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/quirk/lisp/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_SAY)

/datum/quirk/lisp/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(HAS_TRAIT(source, TRAIT_SIGN_LANG))
		return
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		message = replacetext(message,"s","th")
		message = replacetext(message,"x","th")
		speech_args[SPEECH_MESSAGE] = message
