class Op < Struct.new(:name, :logic, :op_code)
  def op_code?
    !op_code.nil?
  end
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

code_matches = {}

instructions = File.readlines("input_01.txt", chomp: true).map(&:chomp).reject(&:empty?).each_slice(3)

result_counter = 0

instructions.each do |before_register_instruction, op_instruction, after_register_instruction|
  before_register = before_register_instruction[/Before: \[(.+)\]/, 1].split(", ").map(&:to_i)
  op_code, a, b, c = op_instruction.split(" ").map(&:to_i)
  after_register = after_register_instruction[/After:  \[(.+)\]/, 1].split(", ").map(&:to_i)

  match_count = 0
  matched_ops = ops.select do |op|
    op.logic.call(a, b, c, before_register.dup ) == after_register
  end

  code_matches[op_code] ||= matched_ops

  code_matches[op_code] = code_matches[op_code] & matched_ops
end


while ops.reject(&:op_code?).count > 0 do
  code_matches.each do |op_code, ops|

    unassigned_ops = ops.reject(&:op_code?)

    if unassigned_ops.count == 1
      unassigned_ops.first.op_code = op_code
    end
  end
end


test_lines = File.readlines("input_02.txt", chomp: true).map(&:chomp).reject(&:empty?)

test_inputs = test_lines.map { |l| l.split(" ").map(&:to_i) }

register = [0,0,0,0]

test_inputs.each do |op_code, a, b, c|
  op = ops.find {|op| op.op_code == op_code}
  register = op.logic.call(a, b, c, register)
end

puts register
