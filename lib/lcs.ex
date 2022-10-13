defmodule LCS do
  def lcs_length(v, w), do: lcs_length(to_charlist(v), to_charlist(w), Map.new()) |> elem(0)

  # Base cases. s_{0,j} = s_{i,0} = 0.
  defp lcs_length([], w, memo), do: {0, Map.put(memo, {[], w}, 0)}
  defp lcs_length(v, [], memo), do: {0, Map.put(memo, {v, []}, 0)}

  # head of v == head of w, we have a match - move diagonally.
  defp lcs_length([h | vrest] = v, [h | wrest] = w, memo) do
    # Find length of path after a diagonal move.
    {len, memo} = lcs_length(vrest, wrest, memo)
    # Return found length + 1 (match), along with the updated memo.
    {len + 1, Map.put(memo, {v, w}, len + 1)}
  end

  # No match - move up or left.
  defp lcs_length([_vh | vrest] = v, [_wh | wrest] = w, memo) do
    # Have we evaluated this before?
    if Map.has_key?(memo, {v, w}) do
      # Simply return the memoized value.
      {Map.get(memo, {v, w}), memo}
    else
      # Left move.
      {len_1, memo_1} = lcs_length(vrest, w, memo)
      # Up move.
      {len_2, memo_2} = lcs_length(v, wrest, memo_1)

      len = max(len_1, len_2)
      {len, Map.put(memo_2, {v, w}, len)}
    end
  end

  def find_lcs(v, w) do
    {v, w} = {to_charlist(v), to_charlist(w)}
    {_, table} = lcs_length(v, w, Map.new())
    find_lcs(v, w, table, []) |> to_string()
  end

  # Base cases.
  def find_lcs([], _w, _table, acc), do: Enum.reverse(acc)
  def find_lcs(_v, [], _table, acc), do: Enum.reverse(acc)

  # Match - add to output string.
  def find_lcs([h | vrest], [h | wrest], table, acc), do: find_lcs(vrest, wrest, table, [h | acc])

  # No match - perform a move along the string giving highest LCS length
  def find_lcs([_vh | vrest] = v, [_wh | wrest] = w, table, acc) do
    if Map.get(table, {vrest, w}) > Map.get(table, {v, wrest}) do
      find_lcs(vrest, w, table, acc)
    else
      find_lcs(v, wrest, table, acc)
    end
  end
end
