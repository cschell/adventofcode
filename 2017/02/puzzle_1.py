import pandas as pd


df = pd.read_table('./input.txt', delim_whitespace=True, header=None)

print((df.max(axis=1) - df.min(axis=1)).sum())
