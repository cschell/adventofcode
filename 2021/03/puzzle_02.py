import pandas as pd
import numpy as np

data = pd.read_csv("input.txt", header=None, sep=" ", dtype=str)

df = data[0].str.split("", expand=True)
df = df[df.columns[1:-1]].astype(int)

report = df.to_numpy()

# %%

def find_sequence(report, comparison_fn):
    mask = np.ones(len(report)).astype(bool)

    for i in range(12):
        target_value = comparison_fn(report[mask, i].mean(), 0.5)
        mask = (report[:, i] == target_value) & mask
        if mask.sum() <= 1:
            return report[mask].squeeze()

oxygen_sequence = find_sequence(report, np.greater_equal)
co2_sequence = find_sequence(report, np.less)

oxygen_sequence_str = "".join(oxygen_sequence.astype(str))
co2_sequence_str = "".join(co2_sequence.astype(str))

print(int(oxygen_sequence_str, 2) * int(co2_sequence_str, 2))