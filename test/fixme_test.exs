defmodule FIXMETest do
  use ExUnit.Case
  import CompileTimeAssertions
  import ExUnit.CaptureIO

  setup context do
    if context[:warnings_enabled] do
      Application.put_env(:fixme, :warn, true)
      on_exit fn -> Application.delete_env(:fixme, :warn) end
    end
    :ok
  end

  test "does not raise before date" do
    import FIXME
    fixme 9999-07-01, "look for jetpack"
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

  test "warns during compile time before the date if passed `warn: true` during invokation, even if an application setting is not present" do
    warning = capture_io(:stderr, fn ->
      Code.eval_string """
        import FIXME
        fixme 9999-07-01, "look for jetpack", warn: true
      """, [], file: "myfile.ex"
    end)
    assert warning =~ "Fix by 9999-07-01: look for jetpack\n  myfile.ex:2"
  end

  @tag warnings_enabled: true
  test "warns during compile before the date if `warn: true` is set in application settings" do
    warning = capture_io(:stderr, fn ->
      Code.eval_string """
        import FIXME
        fixme 9999-07-01, "look for jetpack"
      """, [], file: "myfile.ex"
    end)
    assert warning =~ "Fix by 9999-07-01: look for jetpack\n  myfile.ex:2"
  end

  @tag warnings_enabled: true
  test "does not warn during compile before the date if `warn: true` in application setting, but passed `warn: false` in the macro call" do
    warning = capture_io(:stderr, fn ->
      Code.eval_string """
        import FIXME
        fixme 9999-07-01, "look for jetpack", warn: false
      """, [], file: "myfile.ex"
    end)
    assert warning == ""
  end

  @tag warnings_enabled: true
  test "warns during compile before the date if `warn: true` both in application settings and in the macro call" do
    warning = capture_io(:stderr, fn ->
      Code.eval_string """
        import FIXME
        fixme 9999-07-01, "look for jetpack", warn: true
      """, [], file: "myfile.ex"
    end)
    assert warning =~ "Fix by 9999-07-01: look for jetpack\n  myfile.ex:2"
  end

  @tag warnings_enabled: true
  test "raises on date even if warn is true" do
    assert_compile_time_raise RuntimeError, "Fix by 9999-07-01: look for jetpack", fn ->
      import FIXME
      fixme 9999-07-01, "look for jetpack", today: {9999, 7, 1}
    end
  end

  @tag warnings_enabled: true
  test "raises after date even if warn is true" do
    assert_compile_time_raise RuntimeError, "Fix by 1983-07-26: be born", fn ->
      import FIXME
      fixme 1983-07-26, "be born"
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
