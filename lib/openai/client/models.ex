defmodule Openai.Client.Models do
  @moduledoc """
  List and describe the various models available in the API. You can refer to the Models documentation to understand what models are available and the differences between them.
  """

  use Openai.Client

  @spec list :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Lists the currently available models, and provides basic information about each one such as the owner and availability.
  """
  def list, do: get("/v1/models")

  @spec describe(binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Retrieves a model instance, providing basic information about the model such as the owner and permissioning.
  """
  def describe(model_id), do: get("/v1/models/#{model_id}")
end
