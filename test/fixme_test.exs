defmodule FIXMETest do
  use ExUnit.Case

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
end
