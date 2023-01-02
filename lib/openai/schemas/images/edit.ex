defmodule Openai.Schemas.Images.Edit do
  defstruct [:image, :mask, :prompt, n: 1, size: "256x256", response_format: "url"]

  def new(%{prompt: prompt} = image), do: struct(__MODULE__, image)
  def new([head | _tail] = image) when is_tuple(head), do: struct(__MODULE__, image)

  def new(prompt, n \\ 1, size \\ "256x256", response_format \\ "url") when is_binary(prompt) do
    struct(__MODULE__, %{prompt: prompt, n: n, size: size, response_format: response_format})
  end

  def set_response_format(image, response_format) when response_format in ["b64_json", "url"],
    do: %{image | response_format: response_format}

  def set_response_format(image, response_format)
      when response_format in ["b64", "base64", "BASE64", :base64],
      do: %{image | response_format: "b64_json"}

  def set_response_format(_image, _format),
    do: {:error, "'base64' is not one of ['b64_json', 'url'] - 'response_format'"}

  def set_n(image, n), do: %{image | n: n}
  def set_size(image, size), do: %{image | size: size}

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
