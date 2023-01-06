defmodule Openai.Schemas.Out.Images.Create do
  @moduledoc """
  Given a prompt and/or an input image, the model will generate a new image.
  """

  alias Openai.Helpers.ImageValidations

  @typedoc """
    - Required *\n
  A text description of the desired image(s). The maximum length is 1000 characters.
  """

  @type prompt :: String.t()

  @typedoc """
    - Optional
    - Defaults to 1\n
  The number of images to generate. Must be between 1 and 10.
  """

  @type n :: integer()

  @typedoc """
  Optional
  Defaults to 1024x1024
  The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
  """

  @type size :: String.t()

  @typedoc """
    - Optional
    - Defaults to url\n
  The format in which the generated images are returned. Must be one of url or b64_json.
  """

  @type response_format :: String.t()

  @typedoc """
    - Optional
  A unique identifier representing your end-user, which can help Openai to monitor and detect abuse. [Learn More](https://beta.openai.com/docs/guides/safety-best-practices/end-user-ids).
  """

  @type user :: String.t()

  @typedoc """
  A mapped payload to create a image
  """
  @type t :: %{
          prompt: prompt(),
          n: n(),
          size: size(),
          response_format: response_format()
        }

  defstruct [:prompt, n: 1, size: "1024x1024", response_format: "url"]

  use Vex.Struct
  use ExConstructor

  validates(:prompt, presence: true, length: [max: 1_000], by: &is_binary/1)

  validates(:n,
    number: [less_than_or_equal_to: 10, greater_than_or_equal_to: 1],
    by: &is_integer/1
  )

  validates(:size, by: &ImageValidations.validate_size/1)
  validates(:response_format, by: &ImageValidations.validate_response_format/1)

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
