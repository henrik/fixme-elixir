defmodule FIXME do
  defmacro fixme(
    {:-, _, [{:-, _, [year, month]}, day]},
    message,
    opts \\ :default_opts
  ) do
    {opts, _} = Code.eval_quoted(opts)

    # Injectable "today" for tests.
    current_date = case opts do
      :default_opts -> :calendar.local_time |> elem(0)
      [today: date] -> date
    end

    fixme_date = {year, month, day}

    if current_date >= fixme_date do
      raise "Fix by #{year}-#{zeropad month}-#{zeropad day}: #{message}"
    end
  end

  defp zeropad(number) do
    number |> Integer.to_string |> String.rjust 2, ?0
  end
end
