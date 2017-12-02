import pandas as pd

df = pd.read_table('./input.txt', delim_whitespace=True, header=None)

sum = 0

for index, row in df.iterrows():
  row_value = None
  for _, cell_a in row.iteritems():
    for _, cell_b in row.iteritems():
      if float(cell_a) % float(cell_b) == 0 and cell_a != cell_b:
        row_value = cell_a / cell_b
        break
    if row_value:
      sum += row_value
      break

print(sum)
