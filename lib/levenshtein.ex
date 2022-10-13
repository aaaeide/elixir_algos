defmodule Levenshtein do
  @moduledoc """
  Levenshtein distance is also known as edit distance,
  ie. the smallest number of edits needed to transform one string V
  into another string W.

  Levenshtein distance is a better measure of sequence similarity
  than Hamming distance when working with bioinformatics, as Hamming
  rigidly assumes that the ith symbol of V is aligned with the ith
  symbol of W.
  """

  @doc """
  Finds the edit distance between two strings using Dynamic Programming.
  """
  def ed(v, w) do
    {v, w} = {to_charlist(v), to_charlist(w)}
    ed(v, w, Map.new()) |> elem(0)
  end

  defp ed(v, w, memo) do
    # Used to increment the edit distance after editing.
    incr_dist = fn {dist, memo} -> {dist + 1, memo} end

    if Map.has_key?(memo, {v, w}) do
      # Cache hit!
      {Map.get(memo, {v, w}), memo}
    else
      {dist, memo} =
        case {v, w} do
          # Base case.
          {[], []} ->
            {0, memo}

          # One string is empty, move along the other.
          {[], [_wh | wrest]} ->
            ed([], wrest, memo) |> incr_dist.()

          {[_vh | vrest], []} ->
            ed(vrest, [], memo) |> incr_dist.()

          # Characters are the same, no edit needed.
          {[h | vrest], [h | wrest]} ->
            ed(vrest, wrest, memo)

          # Characters are different, need to edit.
          {v, w} ->
            best_edit(v, w, memo) |> incr_dist.()
        end

      {dist, Map.put(memo, {v, w}, dist)}
    end
  end

  defp best_edit([_vh | vrest] = v, [_wh | wrest] = w, memo) do
    # We have three possible edits: Insertion, deletion and substitution
    {ins, mem1} = ed(v, wrest, memo)
    {del, mem2} = ed(vrest, w, mem1)
    {sub, mem3} = ed(vrest, wrest, mem2)

    dist = Enum.min([ins, del, sub])
    {dist, Map.put(mem3, {v, w}, dist)}
  end
end
