defmodule Openai.Schemas.In.Error do
  defstruct [:code, :message, :param, :type]
  use ExConstructor

  def parse(%{"error" => error}) do
    {:error, new(error)}
  end
end
