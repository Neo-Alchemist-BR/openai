defmodule Openai.Client do
  alias Openai.Client.{Completions, Edits, Image, Models}

  defmacro __using__(_opts) do
    quote do
      use Tesla

      plug(Tesla.Middleware.BaseUrl, "https://api.openai.com")

      plug(Tesla.Middleware.Headers, [
        {"authorization", "Bearer " <> Application.get_env(:openai, :api_key)}
      ])

      plug(Tesla.Middleware.JSON)
    end
  end

  # Completions
  @spec completions(%{
          best_of: integer,
          echo: boolean,
          frequency_penalty: number,
          logit_bias: map,
          logprobs: nil | integer,
          max_tokens: integer,
          model: binary,
          n: integer,
          presence_penalty: number,
          prompt: binary | [binary],
          stop: nil | binary | [binary],
          stream: boolean,
          suffix: nil | binary,
          temperature: number,
          top_p: number,
          user: binary
        }) :: {:error, any} | {:ok, Tesla.Env.t()}
  defdelegate completions(payload), to: Completions

  # Edits
  @spec edits(%{
          model: binary,
          instruction: binary,
          input: binary,
          temperature: number(),
          n: integer(),
          top_p: number()
        }) :: {:error, any} | {:ok, Tesla.Env.t()}
  defdelegate edits(payload), to: Edits, as: :call
  # Embeddings

  # Engines

  # Files

  # Fine Tunes

  # Image
  @spec create_image(%{n: integer, prompt: binary, response_format: binary, size: binary}) ::
          {:error, any} | {:ok, Tesla.Env.t()}
  defdelegate create_image(payload), to: Image, as: :create

  @spec create_image_variation(any) :: {:error, any} | {:ok, Tesla.Env.t()}
  defdelegate create_image_variation(payload), to: Image, as: :create_variation

  @spec edit_image(any) :: {:error, any} | {:ok, Tesla.Env.t()}
  defdelegate edit_image(payload), to: Image, as: :edit

  # Models
  @spec list_models :: {:error, any} | {:ok, Tesla.Env.t()}
  defdelegate list_models(), to: Models, as: :list

  @spec describe_model(binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  defdelegate describe_model(model), to: Models, as: :describe
  # Moderations
end
