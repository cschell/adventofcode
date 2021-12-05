import pandas as pd

data = pd.read_csv("input.txt", header=None, sep=" ", dtype=str)

df = data[0].str.split("", expand=True)
df = df[df.columns[1:-1]].astype(int)

gamma = int("".join((df.mean(axis=0) > 0.5).astype(int).values.astype(str)), 2)
epsilon = int("".join((df.mean(axis=0) < 0.5).astype(int).values.astype(str)), 2)

print(gamma * epsilon)