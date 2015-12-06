require "digest/md5"

module Day4
  class Part1
    def initialize(input)
      @secret = input[0].chop
    end

    def result
      i = 0
      loop do
        hash = Digest::MD5.hexdigest(@secret + i.to_s)

        return i if hash =~ /^0{5}/

        i += 1
      end
    end
  end

  class Part2
    def initialize(input)
      @secret = input[0].chop
    end

    def result
      i = 0
      loop do
        hash = Digest::MD5.hexdigest(@secret + i.to_s)

        return i if hash =~ /^0{6}/

        i += 1
      end
    end
  end
end
