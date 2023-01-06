defmodule Openai.Client.Edits do
  @moduledoc """
  Given a prompt and an instruction, the model will return an edited version of the prompt.
  """
  alias Openai.Client

  alias Openai.Schemas.Out.Edits.Create
  @url "/v1/edits"

  @spec edit(Create.t()) :: {:error, any} | {:ok, map()}
  @doc """
  Creates a new edit for the provided input, instruction, and parameters
  """
  def edit(payload), do: Client.call(@url, payload)
end
