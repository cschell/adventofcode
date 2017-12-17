import numpy as np

with open("input.txt","r") as file:
  raw_input = file.read()

lengths = raw_input.split(",")

sequence = np.arange(256)

skip_size = 0
current_position = 0

for length in lengths:
  length = int(length)

  affected_positions = np.arange(current_position, current_position + length) % sequence.size

  sequence[affected_positions] = np.flip(sequence[affected_positions], 0)

  current_position = (current_position + length + skip_size) % sequence.size
  skip_size += 1

print sequence[0] * sequence[1]
