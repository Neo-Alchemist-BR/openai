defmodule Openai.Client.Files do
  @moduledoc """
  Files are used to upload documents that can be used with features like [Fine-tuning](https://beta.openai.com/docs/api-reference/fine-tunes).
  """
  alias Openai.Client

  alias Openai.Schemas.Out.Files.Upload

  @url "/v1/files"

  @spec list :: {:error, any} | {:ok, map()}
  @doc """
  Returns a list of files that belong to the user's organization.
  """
  def list, do: Client.call(@url)

  @spec describe(binary) :: {:error, any} | {:ok, map()}
  @doc """
  Returns the contents of the specified file
  """
  def describe(file_id), do: Client.call("#{@url}/#{file_id}/content")

  @spec upload(Upload.t()) :: {:error, any} | {:ok, map()}
  @doc """
  Upload a file that contains document(s) to be used across various endpoints/features. Currently, the size of all the files uploaded by one organization can be up to 1 GB. Please contact us if you need to increase the storage limit.
  """
  def upload(payload), do: Client.call(@url, payload)

  @spec del(binary) :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Delete a file by ID.
  """
  def del(file_id), do: Client.delete("#{@url}/#{file_id}")
end
