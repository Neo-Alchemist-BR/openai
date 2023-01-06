defmodule Openai.Embeddings do
  alias Openai.Client.Embeddings
  alias Openai.Schemas.Out.Embeddings.Create, as: Schema

  def call(params) do
    with embeddings <- Schema.new(params) do
      IO.inspect(embeddings)
      Embeddings.create(embeddings)
    end
  end
end
