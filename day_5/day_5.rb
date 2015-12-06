require "pp"
module Day5
  class Part1
    def initialize(words)
      @words = words
    end

    def result
      @words.select do |string|
        word = Word.new(string)
        word.nice?
      end.count
    end

    class Word
      def initialize(string)
        @string = string
      end

      def nice?
        has_no_forbidden_letter_combinations? and
        has_at_least_three_vowls? and
        has_at_least_one_double_letter?
      end

      def naughty?
        !nice?
      end

      def has_at_least_three_vowls?
        @string.count("aeiou") >= 3
      end

      def has_at_least_one_double_letter?
        @string.scan(/([a-z])\1/).count >= 1
      end

      def has_no_forbidden_letter_combinations?
        !@string[/ab|cd|pq|xy/]
      end
    end
  end

  class Part2
    def initialize(words)
      @words = words
    end

    def result
      @words.select do |string|
        word = Word.new(string)
        word.nice?
      end.count
    end

    class Word
      def initialize(string)
        @string = string
      end

      def nice?
        has_at_least_a_pair_of_letters_twice? and
        has_repeating_letter?
      end

      def naughty?
        !nice?
      end

      def has_at_least_a_pair_of_letters_twice?
        (@string.size - 1).times do |i|
          if i > 1
            left = @string[0..i-1]
          else
            left = ""
          end

          if i < @string.size - 1
            right = @string[i+2..-1]
          else
            right = ""
          end

          current_combination = @string.slice(i,2)

          if right.include?(current_combination) || left.include?(current_combination)
            return true
          end
        end

        return false
      end

      def has_repeating_letter?
        !!@string.scan(/([a-z]).\1/).any?
      end
    end
  end
end
