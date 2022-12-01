input_txt = open("01/input.txt").read()

elves = [cals.split("\n") for cals in input_txt.split("\n\n")]

all_cals = []
for elve_cals in elves:
    total_cals = sum([int(c) for c in elve_cals])
    all_cals.append(total_cals)

all_cals = sorted(all_cals)[::-1]

print(f"Top calories: {all_cals[0]}")
print(f"Top 3 calories sum: {sum(all_cals[:3])}")