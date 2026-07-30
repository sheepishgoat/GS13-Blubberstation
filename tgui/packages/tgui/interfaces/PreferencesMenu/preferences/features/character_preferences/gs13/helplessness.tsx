import {
  type Feature,
  FeatureNumberInput,
} from '../../base';

export const no_movement: Feature<number> = {
  name: 'Immobility from weight',
  description: 'At what weight do you become immobile? 0 disables this.',
  component: FeatureNumberInput,
};

export const clumsy: Feature<number> = {
  name: 'Thick fingers from weight',
  description: 'At what weight will you get the "chunky fingers" trait, preventing you from using certain items? 0 disables this.',
  component: FeatureNumberInput,
};

export const low_fov: Feature<number> = {
  name: 'Reduced FOV from weight',
  description: 'At what weight does your fat hinder your FOV? 0 disables this.',
  component: FeatureNumberInput,
};

export const nearsighted: Feature<number> = {
  name: 'Nearsightedness from weight',
  description: 'At what weight do you become nearsighted? 0 disables this.',
  component: FeatureNumberInput,
};

export const hidden_face: Feature<number> = {
  name: 'Hidden face from weight',
  description: 'At what weight does your face become hidden? 0 disables this.',
  component: FeatureNumberInput,
};

export const mute: Feature<number> = {
  name: 'Muteness from weight',
  description: 'At what weight do you become mute? 0 disables this.',
  component: FeatureNumberInput,
};

export const immobile_arms: Feature<number> = {
  name: 'Immobile arms',
  description: 'At what weight do your arms become immobile? 0 disables this.',
  component: FeatureNumberInput,
};

export const clothing_jumpsuit: Feature<number> = {
  name: 'Jumpsuit bursting',
  description: 'At what weight does your jumpsuit burst? 0 disables this.',
  component: FeatureNumberInput,
};

export const clothing_misc: Feature<number> = {
  name: 'Other clothing bursting',
  description:
    'At what weight does your non-jumpsuit clothing burst? 0 disables this.',
  component: FeatureNumberInput,
};

export const belts: Feature<number> = {
  name: 'Belts breaking',
  description:
    'At what weight does your belt break? This will also cause your belt to break if your fullness exceeds stage 2. 0 disables this.',
  component: FeatureNumberInput,
};

export const clothing_back: Feature<number> = {
  name: 'Clothing back bursting',
  description:
    'At what weight do you become unable to wear items on your back? 0 disables this.',
  component: FeatureNumberInput,
};

export const no_buckle: Feature<number> = {
  name: 'No buckling from weight',
  description: 'At what weight do you become unable to be buckled to chairs? 0 disables this.',
  component: FeatureNumberInput,
};

export const chair_breakage: Feature<number> = {
  name: 'Chair breaking',
  description:
    'At what weight will you start breaking chairs? 0 disables this.',
  component: FeatureNumberInput,
};

export const stuckage: Feature<number> = {
  name: 'Door stuckage',
  description:
    'At what weight will you start getting stuck in doors? 0 disables this.',
  component: FeatureNumberInput,
};

export const stuckage_custom: Feature<number> = {
  name: 'Custom Door stuckage chance',
  description:
    'How likely are you to get stuck in doors, if you have the door stuckage preference? Setting this to 0 will reset it to default.',
  component: FeatureNumberInput,
};

export const blueberry_max_before_burst: Feature<number> = {
  name: 'Blueberry inflation bursting limit',
  description:
    'What is the maximum amount of blueberry juice your body can take before bursting. When your character reaches this amount of juice in their body, it will trigger a bursting pop up. You will not burst instantly, but will be given a choice how to handle it or even delay it all together. Setting it to 0 disables bursting.',
  component: FeatureNumberInput,
};

export const no_neck: Feature<number> = {
  name: 'No neck items',
  description: 'At what weight do you become unable to wear items around your neck? 0 disables this.',
  component: FeatureNumberInput,
};

export const waddle: Feature<number> = {
  name: 'Waddling',
  description: 'At what weight do you start waddling? 0 disables this.',
  component: FeatureNumberInput,
};

export const lisp: Feature<number> = {
  name: 'Lisping',
  description: 'At what weight do you start talking with a lisp? 0 disables this.',
  component: FeatureNumberInput,
};

/*
export const weak_lungs: Feature<number> = {
  name: 'Weak lungs',
  description: 'At what weight will you start requiring more oxygen to breathe? Caps at requiring double the oxygen at 3x this pref. 0 disables this.',
  component: FeatureNumberInput,
};
*/
