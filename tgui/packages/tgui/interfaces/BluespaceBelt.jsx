// THIS IS A GS13 UI FILE
import { Box, Section, Dropdown, NumberInput, Knob, Stack, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const belt_modes = [
    "Hide",
    "Show",
];

export const BluespaceBelt = (props) => {
  const { act, data } = useBackend();
  const {
    current_mode,
    BFI_value,
  } = data;

  return (
    <Window title={'Bluespace belt controls'} width={300} height={180}>
      <Window.Content>
        <Section>
        <Stack>
            <Stack.Item color="label">Current mode:</Stack.Item>
            <Stack.Item>
                <Dropdown
                placeholder="Choose belt mode"
                width = "30%"
                selected={current_mode}
                options={belt_modes}
                onSelected={(value) =>
                    act('set_mode', { mode: value })
                }
                />
            </Stack.Item>
        </Stack>
        </Section>
        <Section title="Percentage setting">
        <Knob
            size = {1.5}
            value = {BFI_value}
            minValue = {0}
            maxValue = {100}
            animated = {false}
            step = {0.5}
            stepPixelSize = {2}
            tickWhileDragging = {true}
            onChange={(event, value) =>
            act('set_value', {
                percentage: value,
            })
            }
        />
        </Section>
      </Window.Content>
    </Window>
  );
};
