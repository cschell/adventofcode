import numpy as np
import re
import numpy.ma as ma
from tqdm import tqdm
from IPython import embed

with open("input.txt", "r") as file:
  lines = file.readlines()

patch_data = []

# patch_id, margin_left, margin_top, width, height
for line in tqdm(lines, desc="parsing input"):
  patch = re.match("#\d+ @ (\d+),(\d+): (\d+)x(\d+)", line).groups()

  patch_data += [[int(d) for d in patch]]

# find max x and y
max_x = 0
max_y = 0

for margin_left, margin_top, width, height in tqdm(patch_data, desc="determining dimensions"):
  max_x = max(margin_left + width, max_x)
  max_y = max(margin_top + height, max_y)

cum_patch = np.zeros((max_x, max_y))

for idx, (margin_left, margin_top, width, height) in enumerate(tqdm(patch_data, desc="creating patches")):
  cum_patch[margin_left:(margin_left+width), margin_top:(margin_top+height)] += 1

print(np.sum(cum_patch > 1))
