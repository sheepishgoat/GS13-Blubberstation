import {
  CheckboxInput,
  type Feature,
  FeatureNumberInput,
  type FeatureNumeric,
  type FeatureToggle,
  type FeatureChoiced
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const master_wg_pref: FeatureToggle = {
  name: 'Enable Weight Gain',
  description:
    'This setting is required for all other weight gain preferences to be active. Disabling it will act as if you disabled all methods of weight gain, while also NOT reseting the values of the individual settings. This setting is required to be on in order to gain weight. IMPORTANT: This setting is overriden by taking any helplessness quirks.',
  component: CheckboxInput,
};

export const starting_fatness: Feature<number> = {
  name: 'Starting Fatness',
  description: 'How fat is your character when starting the round?',
  component: FeatureNumberInput,
};

export const weight_gain_rate: FeatureNumeric = {
  name: 'Weight Gain Rate',
  description: 'How quickly do you get fat?',
  component: FeatureNumberInput,
};

export const weight_loss_rate: FeatureNumeric = {
  name: 'Weight Loss Rate',
  description: 'How quickly do you lose fat?',
  component: FeatureNumberInput,
};

export const max_weight: Feature<number> = {
  name: 'Maximum Weight',
  description:
    'What is the maximum weight your character can reach? 0 means there will be no weight cap.',
  component: FeatureNumberInput,
};

export const weight_gain_persistent: FeatureToggle = {
  name: 'Persistent weight',
  description:
    'Toggle whether endround/cryo weight will become your new start weight. This will override your starting fatness.',
  component: CheckboxInput,
};

export const weight_gain_permanent: FeatureToggle = {
  name: 'Permanent weight',
  description:
    'Toggle whether you want to be affected by permanent weight; a special type of fatness that is persistent and impossible to remove using normal means.',
  component: CheckboxInput,
};

export const severe_fatness_penalty: FeatureToggle = {
  name: 'Severe fatness penalties',
  description:
    'Toggle if you want to allow your character to be affected by mechanics which may put severe fatness-related penalties onto your character (such as micro-calorite poisoning).',
  component: CheckboxInput,
};

export const safe_bursting: FeatureToggle = {
  name: 'Safe bursting',
  description:
    'Toggle if you want your character to be unharmed after bursting. Basically putting them back into a non inflated state. If disabled, your character will be safely removed from the round upon bursting. (You are still able to rejoin, similar to vore.)',
  component: CheckboxInput,
};

export const see_bursting: FeatureToggle = {
  name: 'See bursting',
  description: 'Toggle if you want to see people bursting by inflation.',
  component: CheckboxInput,
};

export const bursting_leave_gibs: FeatureToggle = {
  name: 'Leave gibs on Bursting',
  description:
    'Toggle if you want to leave gibs on bursting. You will still leave items and berry juice regardless',
  component: CheckboxInput,
};

export const automatic_bursting: FeatureToggle = {
  name: 'Uncontrollable Bursting',
  description:
    'Toggles your control over bursting. If safe bursting is disabled, this can lead to accidental premature ends for RPs. Use with caution.',
  component: CheckboxInput,
};

export const blueberry_lives: Feature<number> = {
  name: 'Bursts before becoming unsafe.',
  description:
    'How many times will you burst safely before bursting unsafely? This is only used if safe bursting is disabled.',
  component: FeatureNumberInput,
};

export const glutton_fullness_before_burst: Feature<number> = {
  name: 'Bursting fullness',
  description: 'How full past bloated do you want to be before you burst, 0 means you will not be affected by this. 400 is stuffed and 800 is overfilled',
  component: FeatureNumberInput,
};

export const glutton_fatness_before_burst: Feature<number> = {
  name: 'Bursting fatness',
  description: 'How fat in BFI do you want to be before you burst, 0 means you will not be affected by this.',
  component: FeatureNumberInput,
};

export const glutton_bursting_type: FeatureChoiced = {
  name: 'Bursting type',
  description: 'Options for changing your bursting type. Disabled turns off the ability to burst, safe will reset your weight and clear your stomach, injure will damage your stomach and cause some brute damage, crit will do heavy brute damage in addition to destroying your stomach, fatal will kill you and cryo you, permanent fatal will kill you and you\'ll need to be revived.',
  component: FeatureDropdownInput,
}

export const glutton_see_bursting: FeatureToggle = {
  name: 'See bursting',
  description: 'Toggle if you want to see people bursting by being too fat or full.',
  component: CheckboxInput,
};

export const glutton_leave_gibs: FeatureToggle = {
  name: 'Leave gibs on bursting',
  description: 'Toggle if you want to leave gibs on bursting, using perma-fatal bursting will still drop gibs. You will still leave items regardless',
  component: CheckboxInput,
};

export const glutton_enable_messages: FeatureToggle = {
  name: 'Enable flavor messages',
  description: 'Toggle if you would like bursting related flavor messages to display',
  component: CheckboxInput,
};

export const glutton_enable_sounds: FeatureToggle = {
  name: 'Enable sounds',
  description: 'Toggle if you would like bursting related sounds to play',
  component: CheckboxInput,
};
