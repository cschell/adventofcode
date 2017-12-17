import numpy as np

with open("input.txt","r") as file:
  raw_input = file.read().strip()

def decrypt_string(string):
  lengths = map(ord, string) + [17, 31, 73, 47, 23]
  sequence = np.arange(256)

  skip_size = 0
  current_position = 0

  for i in range(64):
    for length in lengths:
      length = int(length)

      affected_positions = np.arange(current_position, current_position + length) % sequence.size

      sequence[affected_positions] = np.flip(sequence[affected_positions], 0)

      current_position = (current_position + length + skip_size) % sequence.size
      skip_size += 1

  output = []

  for i in range(0,255,16):
    output_number = 0
    for number in sequence[i:i+16]:
      output_number ^= number
    output.append(hex(int(output_number))[2:].zfill(2))

  return "".join(output)

print "Empty string: %s" % decrypt_string("")
print "'AoC 2017': %s" % decrypt_string("AoC 2017")
print "Input: %s" % decrypt_string(raw_input)
