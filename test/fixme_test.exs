defmodule FIXMETest do
  use ExUnit.Case
  import CompileTimeAssertions
  import ExUnit.CaptureIO

  test "does not raise before date" do
    import FIXME
    fixme 9999-07-01, "look for jetpack"
  end

  test "warns during compile before the date if warn: true" do
    warning = capture_io(:stderr, fn ->
      Code.eval_string """
        import FIXME
        fixme 9999-07-01, "look for jetpack", warn: true
      """
    end)
    assert warning =~ "Fix by 9999-07-01: look for jetpack"
  end

  test "does not warn during compile before the date if warn: false" do
    warning = capture_io(:stderr, fn ->
      Code.eval_string """
        import FIXME
        fixme 9999-07-01, "look for jetpack", warn: false
      """
    end)
    assert warning == ""
  end

  test "does not warn during compile before the date if warn not provided" do
    warning = capture_io(:stderr, fn ->
      Code.eval_string """
        import FIXME
        fixme 9999-07-01, "look for jetpack"
      """
    end)
    assert warning == ""
  end

  test "raises after date" do
    assert_compile_time_raise RuntimeError, "Fix by 1983-07-26: be born", fn ->
      import FIXME
      fixme 1983-07-26, "be born"
    end
  end

  test "raises on date" do
    assert_compile_time_raise RuntimeError, "Fix by 9999-07-01: look for jetpack", fn ->
      import FIXME
      fixme 9999-07-01, "look for jetpack", today: {9999, 7, 1}
    end
  end

  test "raises after date even if warn is true" do
    assert_compile_time_raise RuntimeError, "Fix by 1983-07-26: be born", fn ->
      import FIXME
      fixme 1983-07-26, "be born", warn: true
    end
  end

  test "sanity" do
    # Let's be extra confident that we can compare dates as tuples.
    assert {2015, 1, 1} > {2014, 12, 31}
    assert {2015, 2, 1} > {2015, 1, 1}
    assert {2015, 1, 2} > {2015, 1, 1}
    assert {2015, 1, 1} == {2015, 1, 1}
  end
end
