defmodule FIXME do
  defmacro fixme(date_expression, message) do
    _fixme(date_expression, message)
  end

  # Public but underscored function for ease of testing (compile-time raise vs. runtime tests).
  def _fixme({:-, _, [{:-, _, [year, month]}, day]}, message) do
    {current_date, _time} = :calendar.local_time
    fixme_date = {year, month, day}
    _fixme(current_date, fixme_date, message)
  end

  # Makes it easier to test date comparisons.
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
