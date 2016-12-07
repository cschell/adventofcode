{:ok, contents} = File.read("./input.txt")

abba_pattern = '((.)(?!\\2)(.))\\3\\2'

contents
  |> String.split("\n")
  |> Enum.filter(fn(line) ->
      Regex.match?(~r/#{abba_pattern}/, line) &&
      !Regex.match?(~r/\[[^\[\]]*#{abba_pattern}[^\[\]]*\]/, line)
    end)
  |> Enum.count
  |> IO.puts
