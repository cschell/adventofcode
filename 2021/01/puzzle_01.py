import pandas as pd

data = pd.read_csv("01/input.txt", header=None)

print((data[0].diff() > 0).sum())
