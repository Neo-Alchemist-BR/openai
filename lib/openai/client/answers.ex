defmodule Openai.Client.Answers do
  alias Openai.Client
  @url "/v1/answers"

  @spec run(any) :: {:error, any} | {:ok, map()}
  def run(payload), do: Client.call(@url, payload)
end
