class Part1
  def initialize(input)
    @old_password = input.first.chomp
  end

  def result
    santas_password = SantaPassword.new(@old_password)
    santas_password.set_to_next_valid_password!
    santas_password
  end
end

class SantaPassword < Struct.new(:password)
  ALPHABET = ("a".."z").to_a

  def increment!
    self.password = (
      self.password.chars
                      .map { |char| ALPHABET.index(char).to_s(26) }
                      .join
                      .to_i(26) + 1
    ).to_s(26)
     .chars
     .map { |char| ALPHABET[char.to_i(26)] }
     .join
  end

  def to_s
    self.password
  end

  def set_to_next_valid_password!
    loop do
      self.increment!
      break if self.valid?
    end
  end

  def valid?
    has_three_consecutive_letters? and
    has_no_confusable_letters? and
    has_two_pairs?
  end

  def has_three_consecutive_letters?
    ALPHABET.each_cons(3) do |cons_chars|
      return true if self.password.include?(cons_chars.join)
    end

    false
  end

  def has_no_confusable_letters?
    !self.password[/[iol]+/]
  end

  def has_two_pairs?
    count = 0
    ALPHABET.each do |char|
      count += 1 if self.password.include?(char + char)
    end
    count >= 2
  end
end
