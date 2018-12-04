import numpy as np
import re
import numpy.ma as ma
from tqdm import tqdm
from IPython import embed

with open("input.txt", "r") as file:
  log_lines = sorted(file.read().splitlines())


# find max guard id
max_guard_id = 0
for line in log_lines:
  match = re.search(r"\#(\d+)", line)

  if not match:
    continue
  result = int(match.group(1))

  max_guard_id = max(max_guard_id, result)

sleep_minutes = np.zeros((max_guard_id, 60))

current_guard_id = None
fall_asleep_minute = None
awake_minute = None
for line in log_lines:
  guard_match = re.search(r"\#(\d+)", line)
  asleep_match = re.search("(\d\d)] falls asleep", line)
  awake_match = re.search("(\d\d)] wakes up", line)

  if guard_match:
    current_guard_id = int(guard_match.group(1))

    if fall_asleep_minute or awake_minute:
      print("danger!")

  elif asleep_match:
    fall_asleep_minute = int(asleep_match.group(1))
    awake_minute = None

  elif awake_match:
    awake_minute = int(awake_match.group(1))
    sleep_minutes[current_guard_id, fall_asleep_minute:awake_minute] += 1
    fall_asleep_minute = None
    awake_minute = None


sleepiest_guard_id = np.argmax(np.sum(sleep_minutes, axis=1))
sleepiest_minute = np.argmax(sleep_minutes[sleepiest_guard_id])

print("answer 1", sleepiest_guard_id * sleepiest_minute)

sleepiest_guard_id = np.argmax(np.max(sleep_minutes, axis=1))
sleepiest_minute = np.argmax(sleep_minutes[sleepiest_guard_id])
print("answer 2", sleepiest_guard_id * sleepiest_minute)
