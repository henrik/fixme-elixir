ExUnit.start()

defmodule CompileTimeAssertions do
  defmacro assert_compile_time_raise(expected_exception, expected_message, fun) do
    expected_exception  # Don't warn about unused variable.

    raised_message = try do
      Code.eval_quoted(fun)
      :did_not_raise
    rescue
      expected_exception -> expected_exception.message
    end

    quote do
      assert unquote(raised_message) == unquote(expected_message)
    end
  end
end
