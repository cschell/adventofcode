class SoundProcessor
  def initialize(instructions)
    @instructions = instructions
    @register = Hash.new(_default = 0)
  end

  def process_all!
    @current_instruction = -1
    loop do
      @current_instruction += 1
      process(*@instructions[@current_instruction])
    end
  end

  def process(cmd, *values)
    send(cmd, *values)
  end

  def snd(register_key)
    @last_played_frequency = @register[register_key]
  end

  def set(register_key, value)
    @register[register_key] = to_value(value)
  end

  def add(register_key, value)
    @register[register_key] += to_value(value)
  end

  def mul(register_key, value)
    @register[register_key] *= to_value(value)
  end

  def mod(register_key, value)
    @register[register_key] %= to_value(value)
  end

  def rcv(register_key)
    return if @register[register_key] == 0

    @register[register_key] = @last_played_frequency
    puts @last_played_frequency
    exit
  end

  def jgz(register_key, value)
    return if @register[register_key] <= 0

    @current_instruction += to_value(value) - 1
  end

  def to_value(val)
    if val.to_i == 0
      @register[val]
    else
      val.to_i
    end
  end
end

input = File.read("input.txt")
instructions = input.each_line.map {|l| l.split(" ") }
SoundProcessor.new(instructions).process_all!

