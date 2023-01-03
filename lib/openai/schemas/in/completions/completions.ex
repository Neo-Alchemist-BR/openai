defmodule Openai.Schemas.In.Completions.Completions do
  alias Openai.Helpers.Check
  alias Openai.Schemas.In.Completions.{Choice, Usage}

  @type t :: %{
          id: binary,
          object: binary,
          created: integer,
          model: binary,
          choices: list(Choice.t()),
          usage: Usage.t()
        }

  defstruct [:id, :object, :created, :model, :choices, :usage]

  use ExConstructor
  use Vex.Struct

  validates(:id, presence: true, uuid: true)
  validates(:usage, by: &__MODULE__.validate_usage/1)
  validates(:choices, by: &__MODULE__.validate_choice/1)
  validates(:object, presence: true, by: &is_binary/1)
  validates(:model, presence: true, by: &is_binary/1)
  validates(:created, presence: true, by: &is_integer/1)

  def validate_choice(value), do: Check.validate_type(value, {:array, Choice})
  def validate_usage(value), do: Check.validate_type(value, Usage)

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
