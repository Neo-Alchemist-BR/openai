defmodule Openai.Client.Embeddings do
  @moduledoc """
  Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.
  Related guide: [Embeddings](https://beta.openai.com/docs/guides/embeddings)
  """

  use Openai.Client
  alias Openai.Schemas.Out.Embeddings.Create

  @spec create(Create.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  def create(payload), do: call("/v1/embeddings", payload)
end
