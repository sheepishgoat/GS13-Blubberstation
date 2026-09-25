/**
 * Unit test for checking if helplessness mechanics have a pref and a config set
 */
/datum/unit_test/helplessness/Run()
	for (var/datum/helplessness/helplessness_mechanic in GLOB.helplessness_mechanics)
		if (isnull(helplessness_mechanic.forced_weight_config))
			TEST_FAIL("[helplessness_mechanic] lacks a forced_weight_config!")
		
		if (isnull(helplessness_mechanic.preference))
			TEST_FAIL("[helplessness_mechanic] lacks an associated preference!")
