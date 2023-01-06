defmodule Openai.Client.Images do
  alias Openai.Client
  alias Openai.Schemas.Out.Images.{Create, Edit, Variations}
  alias Tesla.Multipart

  @url "/v1/images"

  @doc """
  Creates an image given a prompt.
  """
  def create(%Create{prompt: prompt} = payload) when is_binary(prompt),
    do: Client.call("#{@url}/generations", payload)

  @spec create_variation(atom | struct) :: {:error, any} | {:ok, map}
  @doc """
  Creates a variation of a given image.
  """
  def create_variation(%Variations{image: file} = params) when is_binary(file) do
    Client.call("#{@url}/variations", multipart(params), :multipart)
  end

  @spec edit(%{:__struct__ => atom, :image => binary, optional(atom) => any}) ::
          {:error, any} | {:ok, map}
  @doc """
  Creates an edited or extended image given an original image and a prompt.
  """
  def edit(%Edit{image: file} = params) when is_binary(file) do
    Client.call("#{@url}/edits", multipart(params), :multipart)
  end

  defp multipart(params) do
    params
    |> Map.from_struct()
    |> Enum.reduce(
      Multipart.new(),
      fn
        {_key, nil}, acc ->
          acc

        {key, value}, acc when key in [:image, :mask] ->
          Multipart.add_file(acc, value, name: to_string(key))

        {key, value}, acc ->
          Multipart.add_field(acc, to_string(key), to_string(value))
      end
    )
  end
end
