defmodule Openai.Schemas.Out.Edits.Create do
  @moduledoc """
  Given a prompt and an instruction, the model will return an edited version of the prompt.
  """

  @typedoc """
    - Required\n
  ID of the model to use. You can use the List models API to see all of your available models, or see our Model overview for descriptions of them.
  """

  @type model :: String.t()

  @typedoc """
      - Optional
      - Defaults to ""\n
    The input text to use as a starting point for the edit.
  """

  @type input :: String.t()

  @typedoc """
      - Required *
    The instruction that tells the model how to edit the prompt.
  """

  @type instruction :: String.t()

  @typedoc """
    Optional
    Defaults to 1
    How many edits to generate for the input and instruction.
  """

  @type n :: integer

  @typedoc """
    Optional
    Defaults to 1
    What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.

    We generally recommend altering this or top_p but not both.
  """

  @type temperature :: number()

  @typedoc """
  Optional
  Defaults to 1
  An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.

  We generally recommend altering this or temperature but not both.
  """

  @type top_p :: number()

  @type t :: %{
          model: model,
          instruction: instruction(),
          input: input(),
          temperature: temperature(),
          n: n(),
          top_p: top_p()
        }

  defstruct [:model, :instruction, input: "", n: 1, temperature: 1, top_p: 1]

  use Vex.Struct
  use ExConstructor

  validates(:model, presence: true, by: &is_binary/1)
  validates(:instruction, presence: true)
  validates(:n, &is_integer/1)

  validates(:temperature,
    number: [greater_than_or_equal_to: 0, less_than_or_equal_to: 1],
    by: &is_number/1
  )

  validates(:top_p,
    number: [greater_than_or_equal_to: 0, less_than_or_equal_to: 1],
    by: &is_number/1
  )

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
