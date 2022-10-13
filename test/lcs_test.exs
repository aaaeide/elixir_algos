defmodule LCSTest do
  use ExUnit.Case

  test "finds LCS length" do
    v = "ATCTGAT"
    w = "TGCATA"
    assert LCS.lcs_length(v, w) == 4
  end

  test "finds LCS" do
    v = "ATCTGAT"
    w = "TGCATA"
    assert LCS.find_lcs(v, w) == "TCTA"
  end
end
