defmodule Openai.Schemas.Images.Edit do
  defstruct [:image, :mask, :prompt, :n, :size, :response_format]

  def new(description, multiple \\ 1, size \\ "256x256", format \\ "url") do
    struct(__MODULE__, %{prompt: description, n: multiple, size: size, response_format: format})
  end

  def set_response_format(image, format) when format in ["b64_json", "url"], do: %{image | response_format: format}
  def set_response_format(image, format) when format in ["b64", "base64", "BASE64", :base64], do: %{image | response_format: "b64_json"}

  def set_response_format(_image, _format), do: {:error, "'base64' is not one of ['b64_json', 'url'] - 'response_format'"}

  def set_multiple(image, multiple), do: %{image | n: multiple}
  def set_size(image, size), do: %{image | size: size}

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
