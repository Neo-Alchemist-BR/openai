defmodule Openai.Schemas.Out.Images.Edit do
  @moduledoc """
  Creates an edited or extended image given an original image and a prompt.
  """

  alias Openai.Helpers.ImageValidations

  @typedoc """
    - Required *\n
  The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
  """

  @type image :: String.t()

  @typedoc """
    - Optional\n
  An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
  """

  @type mask :: binary()

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
    A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn More](https://beta.openai.com/docs/guides/safety-best-practices/end-user-ids).
  """

  @type user :: String.t()

  @typedoc """
  A mapped payload to edit a image
  """

  @type t :: %{
          image: image(),
          mask: mask(),
          prompt: prompt(),
          n: n(),
          size: size(),
          response_format: response_format()
        }

  defstruct [:image, :mask, :prompt, n: 1, size: "1024x1024", response_format: "url"]

  use Vex.Struct
  use ExConstructor

  validates(:image, presence: true, by: &is_binary/1)
  validates(:mask, &is_binary/1)
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
