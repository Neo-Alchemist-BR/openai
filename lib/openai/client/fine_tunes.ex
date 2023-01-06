defmodule Openai.Client.FineTunes do
  alias Openai.Client
  @url "/v1/fine-tunes"

  @spec list :: {:error, any} | {:ok, map()}
  def list, do: Client.call(@url)

  @spec describe(binary) :: {:error, any} | {:ok, map()}
  def describe(finetune_id), do: Client.call("#{@url}/#{finetune_id}")
end
