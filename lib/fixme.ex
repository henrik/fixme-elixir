defmodule FIXME do
  defmacro fixme({:-, _, [{:-, _, [year, month]}, day]}, message) do
    {current_date, _time} = :calendar.local_time
    fixme_date = {year, month, day}
    _fixme(current_date, fixme_date, message)
  end

  # For ease of testing:
  # - Lets us inject the current date
  # - Lets us test compile-time logic (like exceptions) at runtime
  def _fixme(current_date, fixme_date, message) do
    if current_date >= fixme_date do
      {year, month, day} = fixme_date
      raise "Fix by #{year}-#{zeropad month}-#{zeropad day}: #{message}"
    end
  end

  defp zeropad(number) do
    number |> Integer.to_string |> String.rjust 2, ?0
  end
end
