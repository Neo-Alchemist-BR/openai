defmodule Openai.Client.Completions do
  use Openai.Client
  alias Openai.Schemas.Out.Completions.Completions

  @spec completions(Completions.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  def completions(payload) do
    path = "/v1/completions"
    post(path, payload)
  end
end
