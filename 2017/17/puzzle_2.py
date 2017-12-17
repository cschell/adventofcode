from tqdm import tqdm # pip install tqdm

def position_one_value_after_n(spins, spinlock_steps):
  current_index = 1
  number_after_zero = None
  for buffer_max_index in tqdm(range(1, spins)):
    current_index = (current_index + spinlock_steps) % (buffer_max_index + 1) + 1

    if current_index == 1:
      number_after_zero = buffer_max_index + 1
  return number_after_zero

print position_one_value_after_n(50000000, 301)
