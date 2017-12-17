import numpy as np

spinlock_steps = 301

buffer = np.array([0])

current_index = 1

for i in range(0, 2017):
  max_index = i

  if max_index != 0:
    current_index += spinlock_steps % max_index

    if current_index >= max_index:
      current_index -= i + 1

    current_index += 1

  buffer = np.insert(buffer, current_index, i + 1)

print buffer[current_index + 1]
