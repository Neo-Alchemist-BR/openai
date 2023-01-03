defmodule Openai.Client.Image do
  use Openai.Client

  alias Openai.Schemas.Out.Images.{Create, Edit, Variations}

  @spec create(Create.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  @doc """
  Creates an image given a prompt.
  """
  def create(payload), do: call("/v1/images/generations", payload)

  @doc """
  Creates a variation of a given image.
  """
  @spec create_variation(Variations.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  def create_variation(payload), do: call("/v1/images/variations", payload)

  @doc """
  Creates an edited or extended image given an original image and a prompt.
  """
  @spec edit(Edit.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  def edit(payload),
    do:
      call(
        "/v1/images/edits",
        payload
      )
end
