import pandas as pd

data = pd.read_csv("02/input.txt", header=None, sep=" ")
data.columns = ["direction", "value"]

horizontal = data[data["direction"] == "forward"].value.sum()
data["aim_"] = 0
data.loc[data["direction"] == "down", "aim_"] = data[data["direction"] == "down"].value
data.loc[data["direction"] == "up", "aim_"] = -data[data["direction"] == "up"].value

data["aim"] = data["aim_"].cumsum()

data["horizontal_"] = 0
data.loc[data["direction"] == "forward", "horizontal_"] = data["value"][data["direction"] == "forward"]
data["horizontal"] = data["horizontal_"].cumsum()
data["depth_"] = 0
data.loc[data["direction"] == "forward", "depth_"] = data["value"][data["direction"] == "forward"] * data["aim"][data["direction"] == "forward"]
data["depth"] = data["depth_"].cumsum()

final = data.iloc[-1]

print(final["depth"] * final["horizontal"])


