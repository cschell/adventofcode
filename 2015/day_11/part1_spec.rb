require "rspec"
require "./part1"

describe SantaPassword do
  describe "#has_three_consecutive_letters?" do
    ["abc", "bcd", "aargaergaergabcasdfasdf"].each do |string|
      it "returns true for #{string}" do
        password = SantaPassword.new(string)
        expect(password.has_three_consecutive_letters?).to be_truthy
      end
    end

    ["aaa", "abd", "aargaergaergabscasdfas"].each do |string|
      it "returns false for #{string}" do
        password = SantaPassword.new(string)
        expect(password.has_three_consecutive_letters?).to be_falsy
      end
    end
  end

  describe "#has_no_confusable_letters?" do
    ["abc", "bcd", "aargaergaergabcasdfasdf"].each do |string|
      it "returns true for #{string}" do
        password = SantaPassword.new(string)
        expect(password.has_no_confusable_letters?).to be_truthy
      end
    end

    ["aaia", "abod", "laargaergaergabscasdfas"].each do |string|
      it "returns false for #{string}" do
        password = SantaPassword.new(string)
        expect(password.has_no_confusable_letters?).to be_falsy
      end
    end
  end
end
