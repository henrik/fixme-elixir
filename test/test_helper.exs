ExUnit.start()

defmodule CompileTimeAssertions do
  defmacro assert_compile_time_raise(expected_exception, expected_message, fun) do
    fun = Macro.escape(fun)

    quote do
      assert_raise unquote(expected_exception), unquote(expected_message), fn ->
        Code.eval_quoted(unquote(fun))
      end
    end
  end
end
