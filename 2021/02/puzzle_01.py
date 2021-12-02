import pandas as pd

data = pd.read_csv("02/input.txt", header=None, sep=" ")
data.columns = ["direction", "value"]
# %%

horizontal = data[data["direction"] == "forward"].value.sum()
depth = data[data["direction"] == "down"].value.sum() - data[data["direction"] == "up"].value.sum()

print(horizontal * depth)
