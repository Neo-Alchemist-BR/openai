defmodule Openai.Schemas.Out.Files.Upload do
  @moduledoc """
  Upload a file that contains document(s) to be used across various endpoints/features. Currently, the size of all the files uploaded by one organization can be up to 1 GB. Please contact us if you need to increase the storage limit.
  """

  @typedoc """
  Name of the [JSON Lines](https://jsonlines.readthedocs.io/en/latest/) file to be uploaded.

  If the purpose is set to "fine-tune", each line is a JSON record with "prompt" and "completion" fields representing your [training examples](https://beta.openai.com/docs/guides/fine-tuning/prepare-training-data).
  """

  @type file :: String.t()

  @typedoc """
  The intended purpose of the uploaded documents.

  Use "fine-tune" for [Fine-tuning](https://beta.openai.com/docs/api-reference/fine-tunes). This allows us to validate the format of the uploaded file.
  """

  @type purpose :: String.t()

  @typedoc """
  Mapped Payload to Upload File
  """

  @type t :: %{file: file(), purpose: purpose()}

  defstruct [:file, :purpose]

  use Vex.Struct
  use ExConstructor

  validates(:file, presence: true, by: &is_binary/1)
  validates(:purpose, presence: true, by: &is_binary/1)

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
