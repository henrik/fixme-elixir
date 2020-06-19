defmodule FIXME do
  defmacro fixme(
    {:-, _, [{:-, _, [year, month]}, day]},
    message,
    opts \\ []
  ) do
    {opts, _} = Code.eval_quoted(opts)

    # Injectable "today" for tests.
    current_date = opts[:today] || (:calendar.local_time |> elem(0))

    # Opt into compile time warnings via the application get env
    # Pass the additional option 'warn' to override the application setting
    warn = case opts[:warn] do
      nil ->
        Application.get_env(:fixme, :warn, false)
      warn ->
        warn
    end

    fixme_date = {year, month, day}

    message = "Fix by #{year}-#{zeropad month}-#{zeropad day}: #{message}"
    cond do
      current_date >= fixme_date ->
        raise message
      warn ->
        IO.warn(message)
      true -> true
    end
  end

  defp zeropad(number) do
    number |> Integer.to_string |> String.pad_leading(2, "0")
  end
end
