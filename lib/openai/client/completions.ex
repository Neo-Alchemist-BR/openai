defmodule Openai.Client.Completions do
  alias Openai.Client
  alias Openai.Schemas.Out.Completions.Completions

  @url "/v1/completions"

  @spec completions(Completions.t()) :: {:error, any} | {:ok, map()}
  def completions(payload), do: Client.call(@url, payload)
end
