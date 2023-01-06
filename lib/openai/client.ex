defmodule Openai.Client do
  use Tesla

  alias Openai.Client.{Completions, Embeddings, Edits, Images, Models}
  alias Openai.Config

  alias Openai.Schemas.In.Error
  alias Openai.Schemas.Out
  alias Out.Images.Create, as: CreateImage

  plug(Tesla.Middleware.BaseUrl, Config.api_url())

  plug(Tesla.Middleware.Headers, request_headers())

  plug(Tesla.Middleware.JSON)

  @spec call(binary()) :: {:error, any} | {:ok, map()}
  def call(path) do
    path
    |> get()
    |> handle_response()
  end

  @spec call(binary(), map()) :: {:error, any} | {:ok, map()}
  def call(path, payload) do
    if Vex.valid?(payload) do
      path
      |> post(payload)
      |> handle_response()
    else
      {:error, :bad_request}
    end
  end

  @spec call(binary(), map(), atom()) :: {:error, any} | {:ok, map()}
  def call(path, payload, :multipart) do
    path
    |> post(payload)
    |> handle_response()
  end

  @spec handle_response(any) :: {:error, any} | {:ok, any}
  def handle_response({:ok, %Tesla.Env{body: body, status: 200}}), do: {:ok, body}

  def handle_response({:ok, %Tesla.Env{body: body, status: status}}) when status in 400..499,
    do: {:error, body}

  def handle_response(another_response) do
    IO.inspect(another_response)
    {:error, another_response}
  end

  def parse_error(error), do: Error.parse(error)

  # Client Config
  def add_organization_header(headers) do
    if Config.org_key() do
      [{"OpenAI-Organization", Config.org_key()} | headers]
    else
      headers
    end
  end

  def request_headers do
    [
      bearer(),
      {"Content-type", "application/json"}
    ]
    |> add_organization_header()
  end

  def bearer(), do: {"Authorization", "Bearer #{Config.api_key()}"}
end
