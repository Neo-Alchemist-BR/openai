defmodule Openai.Client.Edits do
  @moduledoc """
  Given a prompt and an instruction, the model will return an edited version of the prompt.
  """
  use Openai.Client

  alias Openai.Schemas.Out.Edits.Edit

  @spec call(Edit.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Creates a new edit for the provided input, instruction, and parameters
  """
  def call(payload) do
    path = "/v1/edits"
    post(path, payload)
  end
end
