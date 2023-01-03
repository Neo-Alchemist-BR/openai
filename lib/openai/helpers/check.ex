defmodule Openai.Helpers.Check do
  @type error :: {:error, any()} | :error
  @type messages :: list(binary) | binary
  @type support_length_types :: list | binary | map | tuple

  @spec validate(any(), keyword()) :: :ok | {:error, messages}
  def validate(value, validators) do
    do_validate(value, validators, :ok)
  end

  defp do_validate(_, [], acc), do: acc

  # check validations one by one
  defp do_validate(value, [h | t] = _validators, acc) do
    case do_validate(value, h) do
      :ok -> do_validate(value, t, acc)
      error -> error
    end
  end

  # validate single validation
  defp do_validate(value, {validator, opts}) do
    case get_validator(validator) do
      {:error, _} = err -> err
      validate_func -> validate_func.(value, opts)
    end
  end

  def validate_type(value, :boolean) when is_boolean(value), do: :ok
  def validate_type(value, :integer) when is_integer(value), do: :ok
  def validate_type(value, :float) when is_float(value), do: :ok
  def validate_type(value, :number) when is_number(value), do: :ok
  def validate_type(value, :string) when is_binary(value), do: :ok
  def validate_type(value, :binary) when is_binary(value), do: :ok
  def validate_type(value, :tuple) when is_tuple(value), do: :ok
  def validate_type(value, :array) when is_list(value), do: :ok
  def validate_type(value, :list) when is_list(value), do: :ok
  def validate_type(value, :atom) when is_atom(value), do: :ok
  def validate_type(value, :function) when is_function(value), do: :ok
  def validate_type(value, :map) when is_map(value), do: :ok

  def validate_type(%{__struct__: struct}, struct_name) when is_struct(struct, struct_name),
    do: :ok

  def validate_type(value, {:array, type}) when is_list(value) do
    # We will check type for each value in the list
    array(value, &validate_type(&1, type))
  end

  # we will add some more validation here
  def validate_type(_, type), do: {:error, "is not a #{type}"}

  def validate_format(value, check) when is_binary(value) do
    if Regex.match?(check, value), do: :ok, else: {:error, "does not match format"}
  end

  def validate_format(_value, _check) do
    {:error, "format check only support string"}
  end

  def validate_inclusion(value, enum) do
    if Enumerable.impl_for(enum) do
      if Enum.member?(enum, value) do
        :ok
      else
        {:error, "not be in the inclusion list"}
      end
    else
      {:error, "given condition does not implement protocol Enumerable"}
    end
  end

  @doc """
  Check if value is **not** included in the given enumerable. Similar to `validate_inclusion/2`
  """
  def validate_exclusion(value, enum) do
    if Enumerable.impl_for(enum) do
      if Enum.member?(enum, value) do
        {:error, "must not be in the exclusion list"}
      else
        :ok
      end
    else
      {:error, "given condition does not implement protocol Enumerable"}
    end
  end

  def validate_number(number, {:equal_to, check_value}) do
    if number == check_value do
      :ok
    else
      {:error, "must be equal to #{check_value}"}
    end
  end

  def validate_number(number, {check, check_value})
      when check in [:min, :greater_than_or_equal_to] do
    if number >= check_value do
      :ok
    else
      {:error, "must be greater than or equal to #{check_value}"}
    end
  end

  def validate_number(number, {:greater_than, check_value}) do
    if number > check_value do
      :ok
    else
      {:error, "must be greater than #{check_value}"}
    end
  end

  def validate_number(number, {check, check_value})
      when check in [:max, :less_than_or_equal_to] do
    if number <= check_value do
      :ok
    else
      {:error, "must be less than or equal to #{check_value}"}
    end
  end

  def validate_number(number, {:less_than, check_value}) do
    if number < check_value do
      :ok
    else
      {:error, "must be less than #{check_value}"}
    end
  end

  @spec validate_number(integer() | float(), keyword()) :: :ok | error
  def validate_number(value, checks) when is_list(checks) and is_number(value) do
    checks
    |> Enum.reduce(:ok, fn
      check, :ok ->
        validate_number(value, check)

      _, error ->
        error
    end)
  end

  def validate_number(_value, _checks) do
    {:error, "must be a number"}
  end

  @spec validate_length(support_length_types, keyword()) :: :ok | error
  def validate_length(value, checks) do
    with length when is_integer(length) <- get_length(value),
         # validation length number
         :ok <- validate_number(length, checks) do
      :ok
    else
      {:error, :wrong_type} ->
        {:error, "length check supports only lists, binaries, maps and tuples"}

      {:error, msg} ->
        # we prepend length to message return by validation number to get full message
        # like: "length must be equal to x"
        {:error, "length #{msg}"}
    end
  end

  @spec get_length(any) :: pos_integer() | {:error, :wrong_type}
  defp get_length(param) when is_list(param), do: length(param)
  defp get_length(param) when is_binary(param), do: String.length(param)
  defp get_length(param) when is_map(param), do: param |> Map.keys() |> get_length()
  defp get_length(param) when is_tuple(param), do: tuple_size(param)
  defp get_length(_param), do: {:error, :wrong_type}

  # loop and validate element in array using `validate_func`
  defp array(data, validate_func)

  defp array([], _) do
    :ok
  end

  # validate recursively, and return error if any vadation failed
  defp array([h | t], validate_func) do
    case validate_func.(h) do
      :ok ->
        array(t, validate_func)

      err ->
        err
    end
  end

  defp get_validator(:type), do: &validate_type/2
  defp get_validator(:format), do: &validate_format/2
  defp get_validator(:number), do: &validate_number/2
  defp get_validator(:length), do: &validate_length/2
  defp get_validator(:in), do: &validate_inclusion/2
  defp get_validator(:not_in), do: &validate_exclusion/2
  defp get_validator(name), do: {:error, "validate_#{name} is not support"}
end
