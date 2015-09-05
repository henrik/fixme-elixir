defmodule FIXMETest do
  use ExUnit.Case

  # We can't (?) test through the actual macro since it would raise at compile time.

  test "parses the given date" do
    assert_raise RuntimeError, "Fix by 1983-07-26: be born", fn ->
      FIXME._fixme (quote do: 1983-07-26), "be born"
    end
  end

  test "raises on date" do
    assert_raise RuntimeError, "Fix by 2015-01-02: boom", fn ->
      FIXME._fixme {2015, 1, 2}, {2015, 1, 2}, "boom"
    end
  end

  test "raises after date" do
    assert_raise RuntimeError, "Fix by 2015-01-02: boom", fn ->
      FIXME._fixme {2015, 1, 3}, {2015, 1, 2}, "boom"
    end
  end

  test "does not raise before date" do
    FIXME._fixme {2015, 1, 1}, {2015, 1, 2}, "boom"
  end

  test "sanity" do
    # Let's be extra confident that we can compare dates as tuples.
    assert {2015, 1, 1} > {2014, 12, 31}
    assert {2015, 2, 1} > {2015, 1, 1}
    assert {2015, 1, 2} > {2015, 1, 1}
  end
end
