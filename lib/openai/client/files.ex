defmodule Openai.Client.Files do
  @moduledoc """
  Files are used to upload documents that can be used with features like [Fine-tuning](https://beta.openai.com/docs/api-reference/fine-tunes).
  """
  use Openai.Client

  alias Openai.Schemas.Out.Files.Upload

  @spec list :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Returns a list of files that belong to the user's organization.
  """
  def list, do: get("/v1/files")

  @spec describe(binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Returns the contents of the specified file
  """
  def describe(file_id), do: get("/v1/files/#{file_id}/content")

  @spec upload(Upload.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Upload a file that contains document(s) to be used across various endpoints/features. Currently, the size of all the files uploaded by one organization can be up to 1 GB. Please contact us if you need to increase the storage limit.
  """
  def upload(payload), do: call("/v1/files", payload)

  @spec del(binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Delete a file by ID.
  """
  def del(file_id), do: delete("/v1/files/#{file_id}")
end
