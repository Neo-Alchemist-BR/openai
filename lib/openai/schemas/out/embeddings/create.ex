defmodule Openai.Schemas.Out.Embeddings.Create do
  @moduledoc """
  Creates an embedding vector representing the input text.
  """

  @typedoc """
  ID of the model to use. You can use the [List models](https://beta.openai.com/docs/api-reference/models/list) API to see all of your available models,
  or see our [Model overview](https://beta.openai.com/docs/models/overview) for descriptions of them.
  """

  @type model :: String.t()

  @typedoc """
  Input text to get embeddings for, encoded as a string or array of tokens. To get embeddings for multiple inputs in a single request, pass an array of strings or array of token arrays. Each input must not exceed 8192 tokens in length.
  """

  @type input :: String.t() | list(String.t())

  @typedoc """
  A unique identifier representing your end-user, which can help Openai to monitor and detect abuse.
  [Learn more](https://beta.openai.com/docs/guides/safety-best-practices/end-user-ids).
  """

  @type user :: String.t()

  @typedoc """
  A mapped Embeddings create payload
  """

  @type t :: %{
          model: model(),
          input: input(),
          user: user()
        }

  defstruct [:model, :input, user: ""]
  use Vex.Struct
  use ExConstructor

  validates(:model, presence: true, by: &is_binary/1)
  validates(:input, presence: true, by: &__MODULE__.binary_or_list_of_binary/1)

  @spec binary_or_list_of_binary(any) :: boolean
  def binary_or_list_of_binary(term) when is_binary(term), do: true
  def binary_or_list_of_binary(term) when is_list(term), do: Enum.all?(term, &is_binary/1)
  def binary_or_list_of_binary(_term), do: false

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
