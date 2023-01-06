defmodule Openai.Schemas.Out.Images do
  alias Openai.Schemas.Out.Images.{Create, Edit, Variations}

  @typedoc """
    - Required *\n
  The image to edit or use as the basis for the variation(s). Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
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
  A unique identifier representing your end-user, which can help Openai to monitor and detect abuse. [Learn More](https://beta.openai.com/docs/guides/safety-best-practices/end-user-ids).
  """

  @type user :: String.t()

  @spec set_description(Create.t() | Edit.t() | Variations.t(), prompt) ::
          Create.t() | Edit.t() | Variations.t()
  def set_description(image, prompt), do: %{image | prompt: prompt}

  @spec set_response_format(Create.t() | Edit.t() | Variations.t(), response_format()) ::
          {:error, <<_::496>>} | Create.t() | Edit.t() | Variations.t()
  def set_response_format(image, response_format) when response_format in ["b64_json", "url"],
    do: %{image | response_format: response_format}

  def set_response_format(image, response_format)
      when response_format in ["b64", "base64", "BASE64", :base64],
      do: %{image | response_format: "b64_json"}

  def set_response_format(image, format),
    do: %{image | response_format: format}

  @spec set_n(Create.t() | Edit.t() | Variations.t(), n()) ::
          Create.t() | Edit.t() | Variations.t()
  def set_n(image, n), do: %{image | n: n}

  @spec set_size(Create.t() | Edit.t() | Variations.t(), size()) ::
          Create.t() | Edit.t() | Variations.t()
  def set_size(image, size), do: %{image | size: size}

  @spec set_image(Edit.t() | Variations.t(), image()) :: Edit.t() | Variations.t()
  def set_image(image, background_image), do: %{image | image: background_image}

  @spec set_mask(Edit.t() | Variations.t(), mask()) :: Edit.t() | Variations.t()
  def set_mask(image, mask), do: %{image | mask: mask}
end
