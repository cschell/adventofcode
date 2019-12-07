import numpy as np
import re
import numpy.ma as ma
from tqdm import tqdm
from IPython import embed
np.set_printoptions(threshold=np.nan)
with open("input.txt", "r") as file:
  coordinates = [line.split(", ") for line in file.read().splitlines()]

coordinates = np.array([[int(i[0]), int(i[1])] for i in coordinates])

max_x, max_y = np.max(coordinates, axis=0)

field = np.zeros((max_x, max_y), dtype=int) - 1 #.reshape(max_x, max_y) - 1

for x,y in tqdm(np.ndindex(field.shape), total=max_x*max_y):
  min_distance = 99999
  nearest_coord = -1

  for coord_idx, coord in enumerate(coordinates):
    distance = abs(coord[0] - x) + abs(coord[1] - y)

    if distance < min_distance:
      nearest_coord = coord_idx
      min_distance = distance
    elif distance == min_distance:
      nearest_coord = -1

  field[x,y] = nearest_coord

field_count = np.bincount(field[field >= 0])

edge_fields = np.unique(list(field[0,:]) + list(field[:,0]) + list(field[-1,:]) + list(field[:,-1]))
edge_fields = edge_fields[edge_fields >= 0]
field_count_mask = np.ones((len(field_count),), dtype=int)
field_count_mask[edge_fields] = False
# for line in field:
#   print(" ".join(list(["%2d" % int(s) for s in line])))

print(np.max(field_count[field_count_mask == 1]))

embed()

#embed()
