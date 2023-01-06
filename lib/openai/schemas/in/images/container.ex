defmodule Openai.Schemas.In.Images.Container do
  alias Openai.Schemas.In.Images.Response
  defstruct [:created, :data]

  use Vex.Struct
  use ExConstructor

  validates(:created, &is_integer/1)
  validates(:data, &is_list/1)

  def parse_container_content(%{data: data} = container) when is_list(data) do
    data = Stream.map(data, &Response.new/1) |> Enum.to_list()
    %{container | data: data}
  end

  def parse_container_content(%{data: data} = container) do
    %{container | data: Response.new(data)}
  end
end
