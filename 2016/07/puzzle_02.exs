defmodule Day07Puzzle02 do
  @aba_bab_regex ~r/(?<aba>(?P<A>.)(?!\k<A>)(?P<B>.)\k<A>) .* \[ [^\[\]]* (?<bab>\k<B>\k<A>\k<B>) [^\[\]]* \]/x
  @bab_aba_regex ~r/ \[ [^\[\]]* (?<bab>(?P<A>.)(?!\k<A>)(?P<B>.)\k<A>)  [^\[\]]* \] .* (?<aba>\k<B>\k<A>\k<B>)/x

  def got_ssl?(line) do
    check_for_ssl_with_regex(line, @aba_bab_regex) ||
      check_for_ssl_with_regex(line, @bab_aba_regex)
  end

  def check_for_ssl_with_regex(line, regex) do
    Regex.scan(regex, line, [capture: [:aba, :bab]])
    |> Enum.map(fn([aba, bab]) ->
      cleaned_line = Regex.replace(~r/\[ [^\[\]]* #{aba} [^\[\]]* \]/x, line, "[#{bab}]")
      Regex.match?(regex, cleaned_line)
    end)
    |> Enum.any?
  end
end

{:ok, contents} = File.read("./input.txt")

contents
  |> String.split("\n")
  |> Enum.filter(&Day07Puzzle02.got_ssl?/1)
  |> Enum.count
  |> IO.puts
