defmodule Openai.Client.Models do
  @moduledoc """
  List and describe the various models available in the API. You can refer to the Models documentation to understand what models are available and the differences between them.
  """

  alias Openai.Client

  @url "/v1/models"

  @spec list :: {:error, any} | {:ok, map()}
  @doc """
  Lists the currently available models, and provides basic information about each one such as the owner and availability.
  """
  def list, do: Client.call(@url)

  @spec describe(binary) :: {:error, any} | {:ok, map()}
  @doc """
  Retrieves a model instance, providing basic information about the model such as the owner and permissioning.
  """
  def describe(model_id), do: Client.call("#{@url}/#{model_id}")
end
