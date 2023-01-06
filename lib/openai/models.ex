defmodule Openai.Models do
  alias Openai.Client.Models
  alias Openai.Schemas.In.Models.Container

  require Logger

  def call do
    with {:ok, response} <- Models.list(),
         %Container{} = data <- parse_response(response) do
      data
    end
    |> IO.inspect()
  end

  def call(model_id) do
    with {:ok, response} <- Models.describe(model_id),
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

  # @spec create(map() | keyword()) :: {:error, any()} | map()
  # def create(params) do
  #   with %CreateRequest{} = payload <- CreateRequest.new(params),
  #        {:ok, response} <- Images.create(payload),
  #        %Container{data: [%CreateResponse{} | _tail]} = out <-
  #          Client.parse_response(response, CreateResponse) do
  #     out
  #   else
  #     {:error, reason} ->
  #       Logger.error(reason)
  #       {:error, reason}
  #   end
  # end
end
