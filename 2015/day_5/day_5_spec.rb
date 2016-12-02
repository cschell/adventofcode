require "rspec"
require "./day_5"

describe Day5::Part1::Word do
  describe ".at_least_three_vowls?" do
    valid_strings = %w(aei xazegov aeiouaeiouaeiou)
    invalid_strings = %w(z a bs uztwm manbu)

    valid_strings.each do |valid_string|
      it "returns true for string #{valid_string}" do
        word = Day5::Part1::Word.new(valid_string)
        expect(word.has_at_least_three_vowls?).to be_truthy
      end
    end

    invalid_strings.each do |invalid_string|
      it "returns true for string #{invalid_string}" do
        word = Day5::Part1::Word.new(invalid_string)
        expect(word.has_at_least_three_vowls?).to be_falsy
      end
    end
  end

  describe ".at_least_one_double_letter?" do
    valid_strings = %w(xx abcdde aabbccdd)
    invalid_strings = %w(asdfghjk n m m mnm aoeu asdasd)

    valid_strings.each do |valid_string|
      it "returns true for string #{valid_string}" do
        word = Day5::Part1::Word.new(valid_string)
        expect(word.has_at_least_one_double_letter?).to be_truthy
      end
    end

    invalid_strings.each do |invalid_string|
      it "returns true for string #{invalid_string}" do
        word = Day5::Part1::Word.new(invalid_string)
        expect(word.has_at_least_one_double_letter?).to be_falsy
      end
    end
  end

  describe ".has_no_forbidden_letter_combinations?" do
    valid_strings = %w(xx acbddewdqpbadc bdasd)
    invalid_strings = %w(ab cd pq xy asab asdfcdfdas efreafpqwefwe aefasdfxy)

    valid_strings.each do |valid_string|
      it "returns true for string #{valid_string}" do
        word = Day5::Part1::Word.new(valid_string)
        expect(word.has_no_forbidden_letter_combinations?).to be_truthy
      end
    end

    invalid_strings.each do |invalid_string|
      it "returns true for string #{invalid_string}" do
        word = Day5::Part1::Word.new(invalid_string)
        expect(word.has_no_forbidden_letter_combinations?).to be_falsy
      end
    end
  end
end

describe Day5::Part2::Word do
  describe "#has_at_least_a_pair_of_letters_twice?" do
    valid_strings = %w(xyxy aaaa aabbbbcc aabcdefgaa xyxyxyxy xyxxyxy xyxyxy)
    invalid_strings = %w(aaa abbbaa aaccdd)

    valid_strings.each do |valid_string|
      it "returns true for string #{valid_string}" do
        word = Day5::Part2::Word.new(valid_string)
        expect(word.has_at_least_a_pair_of_letters_twice?).to be_truthy
      end
    end

    invalid_strings.each do |invalid_string|
      it "returns true for string #{invalid_string}" do
        word = Day5::Part2::Word.new(invalid_string)
        expect(word.has_at_least_a_pair_of_letters_twice?).to be_falsy
      end
    end
  end
end

describe Day5::Part2::Word do
  describe "#has_repeating_letter?" do
    valid_strings = %w(xyx abcdefeghi even aaa)
    invalid_strings = %w(xyz xx aabbcc)

    valid_strings.each do |valid_string|
      it "returns true for string #{valid_string}" do
        word = Day5::Part2::Word.new(valid_string)
        expect(word.has_repeating_letter?).to be_truthy
      end
    end

    invalid_strings.each do |invalid_string|
      it "returns true for string #{invalid_string}" do
        word = Day5::Part2::Word.new(invalid_string)
        expect(word.has_repeating_letter?).to be_falsy
      end
    end
  end
end
