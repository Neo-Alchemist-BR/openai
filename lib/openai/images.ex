defmodule Openai.Images do
  alias Openai.Client
  alias Openai.Client.Images
  alias Openai.Schemas.Out.Images.Create, as: CreateRequest
  alias Openai.Schemas.Out.Images.Edit, as: EditRequest
  alias Openai.Schemas.Out.Images.Variations, as: VariationsRequest
  alias Openai.Schemas.In.Images.Container
  alias Openai.Schemas.In.Images.Response, as: ImagesResponse

  require Logger

  @spec create(map() | keyword()) :: {:error, any()} | map()
  def create(params) do
    with %CreateRequest{} = payload <- CreateRequest.new(params),
         {:ok, response} <- Images.create(payload),
         %Container{data: [%ImagesResponse{} | _tail]} = out <- parse_response(response) do
      out
    else
      {:error, reason} ->
        Logger.error(reason)
        Client.parse_error(reason)
    end
  end

  @spec edit(map() | keyword()) :: {:error, any()} | map()
  def edit(params) do
    with %EditRequest{} = payload <- EditRequest.new(params),
         {:ok, response} <- Images.edit(payload),
         %Container{data: [%ImagesResponse{} | _tail]} = out <-
           parse_response(response) do
      out
    else
      {:error, reason} ->
        Logger.error(reason)
        Client.parse_error(reason)
    end
  end

  @spec create_variation(map() | keyword()) :: {:error, any()} | map()
  def create_variation(params) do
    with %VariationsRequest{} = payload <- VariationsRequest.new(params),
         {:ok, response} <- Images.create_variation(payload),
         %Container{data: [%ImagesResponse{} | _tail]} = out <-
           parse_response(response) do
      out
    else
      {:error, reason} ->
        Logger.error(reason)
        Client.parse_error(reason)
    end
  end

  @spec parse_response([{atom | binary, any}] | %{optional(atom | binary) => any}) :: %{
          :data => list | %Openai.Schemas.In.Images.Response{b64_json: any, url: any},
          optional(any) => any
        }
  def parse_response(response) do
    with %Container{} = container <- Container.new(response),
         %Container{data: _data} = out <- Container.parse_container_content(container) do
      out
    end
  end
end
