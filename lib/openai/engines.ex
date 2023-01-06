defmodule Openai.Engines do
  alias Openai.Client.Engines
  alias Openai.Schemas.In.Models.Container

  require Logger

  def call do
    with {:ok, response} <- Engines.list(),
         %Container{} = data <- parse_response(response) do
      data
    end
    |> IO.inspect()
  end

  def call(model_id) do
    with {:ok, response} <- Engines.describe(model_id),
         %Container{} = data <- parse_response(response) do
      data
    end
    |> IO.inspect()
  end

  def parse_response(response) do
    with %Container{} = container <- Container.new(data: response),
         %Container{data: _data} = out <- Container.parse_container_content(container) do
      out
    end
  end
end
