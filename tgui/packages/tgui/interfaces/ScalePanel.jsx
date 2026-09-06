// THIS IS A GS13 UI FILE
import { Box, LabeledList, ProgressBar, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ScalePanel = (props) => {
  const { act, data } = useBackend();
  const {
    currently_weighing,
    most_recent_carbon,
    total_weight,
    total_weight_pounds,
    bmi,
    total_muscle,
    total_muscle_pounds,
    total_fatness,
    total_fatness_pounds,
    wg_rate,
    wl_rate,
    mg_rate,
    ml_rate,
    weight_data,
  } = data;

  return (
    <Window title={'Weight Readout'} width={500} height={600} resizable>
      <Window.Content scrollable>
        <Section>
          <Box textAlign="center" fontSize="18px">
            {currently_weighing ? 'Currently Weighing' : 'Last User Weighed'}:
            <b>{most_recent_carbon ? most_recent_carbon : 'None'}</b>
          </Box>
          <Box textAlign="center" fontSize="15px">
            Total Weight: <b>{total_weight_pounds} Pounds</b><br/>
            BMI: <b>{bmi}</b>
          </Box>
        </Section>

        <Section title="Totals">
          <LabeledList>
            <LabeledList.Item label="Weight">
              <ProgressBar value={total_weight} maxValue={total_weight}>
                {total_weight_pounds} {'Pounds ('}
                {total_weight} {' BFI/MMI)'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Fatness">
              <ProgressBar value={total_fatness} maxValue={total_weight}>
                {total_fatness_pounds} {'Pounds ('}
                {total_fatness} {' BFI)'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Muscle">
              <ProgressBar value={total_muscle} maxValue={total_weight}>
                {total_muscle_pounds} {'Pounds ('}
                {total_muscle} {' MMI)'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>

        {weight_data.map((category) => (
          <Section key={category.name} title={category.name}>
            <LabeledList>
              {category.data_points.map((data_point) => (
                <LabeledList.Item key={data_point.name} label={data_point.name}>
                  <ProgressBar
                    value={data_point.value}
                    maxValue={
                      category.muscle_category
                        ? total_muscle
                          ? total_muscle
                          : 1
                        : total_fatness
                          ? total_fatness
                          : 1
                    }
                  >
                    {data_point.pounds} {'Pounds ('}
                    {data_point.value}{' '}
                    {category.muscle_category ? 'MMI' : 'BFI'}
                    {')'}
                  </ProgressBar>
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        ))}
        <Section title="Gain and Loss Rates">
          <LabeledList>
            <LabeledList.Item label="Weight Gain">{wg_rate}</LabeledList.Item>
            <LabeledList.Item label="Weight Loss">{wl_rate}</LabeledList.Item>
            <LabeledList.Item label="Muscle Gain">{mg_rate}</LabeledList.Item>
            <LabeledList.Item label="Muscle Loss">{ml_rate}</LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
