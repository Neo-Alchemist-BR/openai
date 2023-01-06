defmodule Openai.Client.Embeddings do
  @moduledoc """
  Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.
  Related guide: [Embeddings](https://beta.openai.com/docs/guides/embeddings)
  """

  alias Openai.Client
  alias Openai.Schemas.Out.Embeddings.Create

  @url "/v1/embeddings"
  @spec create(Create.t()) :: {:error, any} | {:ok, map()}
  def create(payload), do: Client.call(@url, payload)
end
