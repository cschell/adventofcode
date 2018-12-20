class Op < Struct.new(:name, :logic)
end

ops = [
  Op.new("addr", -> (a, b, c, r) {r = r.dup; r[c] = r[a] + r[b];          r }),
  Op.new("addi", -> (a, b, c, r) {r = r.dup; r[c] = r[a] + b;             r }),
  Op.new("mulr", -> (a, b, c, r) {r = r.dup; r[c] = r[a] * r[b];          r }),
  Op.new("muli", -> (a, b, c, r) {r = r.dup; r[c] = r[a] * b;             r }),
  Op.new("banr", -> (a, b, c, r) {r = r.dup; r[c] = r[a] & r[b];          r }),
  Op.new("bani", -> (a, b, c, r) {r = r.dup; r[c] = r[a] & b;             r }),
  Op.new("borr", -> (a, b, c, r) {r = r.dup; r[c] = r[a] | r[b];          r }),
  Op.new("bori", -> (a, b, c, r) {r = r.dup; r[c] = r[a] | b;             r }),
  Op.new("setr", -> (a, _, c, r) {r = r.dup; r[c] = r[a];                 r }),
  Op.new("seti", -> (a, _, c, r) {r = r.dup; r[c] = a;                    r }),
  Op.new("gtir", -> (a, b, c, r) {r = r.dup; r[c] = a    >  r[b] ? 1 : 0; r }),
  Op.new("gtri", -> (a, b, c, r) {r = r.dup; r[c] = r[a] >  b    ? 1 : 0; r }),
  Op.new("gtrr", -> (a, b, c, r) {r = r.dup; r[c] = r[a] >  r[b] ? 1 : 0; r }),
  Op.new("eqir", -> (a, b, c, r) {r = r.dup; r[c] = a    == r[b] ? 1 : 0; r }),
  Op.new("eqri", -> (a, b, c, r) {r = r.dup; r[c] = r[a] == b    ? 1 : 0; r }),
  Op.new("eqrr", -> (a, b, c, r) {r = r.dup; r[c] = r[a] == r[b] ? 1 : 0; r }),
]

instructions = File.readlines("input.txt", chomp: true).map(&:chomp).reject(&:empty?).each_slice(3)

result_counter = 0

instructions.each do |before_register_instruction, op_instruction, after_register_instruction|
  before_register = before_register_instruction[/Before: \[(.+)\]/, 1].split(", ").map(&:to_i)
  _op_code, a, b, c = op_instruction.split(" ").map(&:to_i)
  after_register  = after_register_instruction[/After:  \[(.+)\]/, 1].split(", ").map(&:to_i)

  match_count = 0
  ops.each do |op|
    if op.logic.call(a, b, c, before_register.dup ) == after_register
      match_count += 1
    end
  end

  if match_count >= 3
    result_counter += 1
  end
end

puts result_counter
