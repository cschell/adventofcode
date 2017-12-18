require "thread"
class SoundProcessor
  attr_accessor :partner
  attr_reader :status
  attr_reader :output_counter
  attr_reader :id
  attr_accessor :input

  def initialize(id, instructions, mutex)
    @id = id
    @instructions = instructions
    @mutex = mutex
    @output_counter = 0
    @register = Hash.new(_default = 0)
    @status = :working
    @register["p"] = @id
  end

  def process_all!
    @current_instruction = -1

    catch(:finished) do
      loop do
        @current_instruction += 1
        ins = @instructions[@current_instruction]
        process(*ins)
      end
    end
  end

  def process(cmd, *values)
    send(cmd, *values)
  end

  def output
    @output ||= []
  end

  def snd(register_key)
    @mutex.synchronize do
      output.push(@register[register_key])
    end
    @output_counter += 1
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
    @status = :waiting

    val = nil

    while val.nil?
      @mutex.synchronize do
        val = partner.output.shift
      end

      if val.nil? && partner.output.empty? && output.empty? && partner.waiting?
        throw(:finished)
      end
    end
    @status = :working
    @register[register_key] = val.to_i
  end

  def waiting?
    status == :waiting
  end

  def jgz(a, b)
    return if to_value(a) <= 0

    @current_instruction += to_value(b) - 1
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

mutex = Mutex.new
sp0 = SoundProcessor.new(0, instructions, mutex)
sp1 = SoundProcessor.new(1, instructions, mutex)

sp0.partner = sp1
sp1.partner = sp0

[
  Thread.fork { sp0.process_all! },
  Thread.fork { sp1.process_all! }
].map(&:join)

puts sp1.output_counter
