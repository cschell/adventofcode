require "pp"
module Day7
  class Part1
    def initialize(input)
      @instructions = input
      @wires = Hash.new
    end

    def result
      @instructions.each do |instruction|
        if instruction =~ /^([a-z0-9]*)(\s?([A-Z]+) (\w+))? -> (\w+)$/
          command, target = $3, $5
          arguments = [$1, $4].map do |argument|
            -> { @wires.fetch(argument) { Wire.new(RAW.new([ -> {argument.to_i }])) }.signal }
          end

          @wires[target] = Wire.new(eval(command || "RAW").new(arguments))
        end
      end

      @wires["a"].signal
    end

    def translate_arguments(*args)

    end

    class Wire < Struct.new(:operation)
      attr_writer :signal

      def signal
        @signal ||= operation.call
      end

      def reset
        @signal = nil
      end
    end

    class Operation < Struct.new(:args)
    end

    class NOT < Operation
      def call
        ~(args[1].call)
      end
    end

    class AND < Operation
      def call
        args[0].call & args[1].call
      end
    end

    class OR < Operation
      def call
        args[0].call | args[1].call
      end
    end

    class LSHIFT < Operation
      def call
        args[0].call << args[1].call
      end
    end

    class RSHIFT < Operation
      def call
        args[0].call >> args[1].call
      end
    end

    class RAW < Operation
      def call
        args[0].call
      end
    end
  end

  class Part2 < Part1
    def result
      super
      @wires["b"].signal = @wires["a"].signal
      @wires.each {|wire_name, wire| wire.reset unless wire_name == "b" }
      @wires["a"].signal
    end
  end
end
