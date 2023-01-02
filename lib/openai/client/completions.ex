defmodule Openai.Client.Completions do
  use Openai.Client

  def completions(payload) do
    path = "/v1/completions"
    post(path, payload)
  end
end
