defmodule Openai.Schemas.In.Models.Container do
  alias Openai.Schemas.In.Models.Model
  defstruct [:data]

  use Vex.Struct
  use ExConstructor

  @spec parse_container_content(%{:data => maybe_improper_list | map, optional(any) => any}) :: %{
          :data => list | %{:permission => list, optional(any) => any},
          optional(any) => any
        }
  def parse_container_content(%{data: %{"data" => data}} = container) when is_list(data) do
    data = Stream.map(data, &Model.build/1) |> Enum.to_list()
    %{container | data: data}
  end

  def parse_container_content(%{data: data} = container) when is_list(data) do
    data = Stream.map(data, &Model.build/1) |> Enum.to_list()
    %{container | data: data}
  end

  def parse_container_content(%{data: data} = container) do
    IO.inspect(container)
    %{container | data: Model.build(data)}
  end
end
