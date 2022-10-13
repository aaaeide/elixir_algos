defmodule LevenshteinTest do
  use ExUnit.Case

  test "finds edit distance 1" do
    assert Levenshtein.ed("AGCTTAGC", "GCTAGGA") == 4
  end

  test "finds edit distance 2" do
    assert Levenshtein.ed("KITTEN", "SITTING" == 3)
  end

  test "finds edit distance 3" do
    assert Levenshtein.ed("SATURDAY", "SUNDAY" == 3)
  end

  test "finds trivial edit distances 1" do
    assert Levenshtein.ed("", "") == 0
  end

  test "finds trivial edit distances 2" do
    assert Levenshtein.ed("A", "G") == 1
  end

  test "finds trivial edit distances 3" do
    assert Levenshtein.ed("AAAA", "AAAA") == 0
  end

  # test "finds alignment" do
  #   v = "AGCTTAGC"
  #   w = "GCTAGGA"

  #   assert Levenshtein.alignment(v, w) == {
  #            'AGCTTAGC-',
  #            '-GCT-AGGA'
  #          }
  # end
end
