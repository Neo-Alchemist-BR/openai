defmodule Openai.Client.Classifications do
  alias Openai.Client
  @url "/v1/classifications"

  @spec create(any) :: {:error, any} | {:ok, map()}
  def create(payload), do: Client.call(@url, payload)
end
