defmodule FIXME do
  defmacro fixme(
    {:-, _, [{:-, _, [year, month]}, day]},
    message,
    opts \\ []
  ) do
    {opts, _} = Code.eval_quoted(opts)

    # Injectable `today` for tests.
    current_date = opts[:today] || (:calendar.local_time |> elem(0))

    warn? =
      case opts[:warn] do
        nil  -> Application.get_env(:fixme, :warn, false)
        warn? -> warn?
      end

    fixme_date = {year, month, day}
    due? = current_date >= fixme_date

    message = "Fix by #{year}-#{zeropad(month)}-#{zeropad(day)}: #{message}"
    cond do
      due?  -> raise message
      warn? ->
        %{file: file, line: line} = __CALLER__
        IO.warn(message <> "\n  #{file}:#{line}", [])
      true  -> nil
    end
  end

  defp zeropad(number) do
    number |> Integer.to_string |> String.pad_leading(2, "0")
  end
end
