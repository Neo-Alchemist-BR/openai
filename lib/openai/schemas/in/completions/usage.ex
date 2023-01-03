defmodule Openai.Schemas.In.Completions.Usage do
  @type t :: %{
          prompt_tokens: integer,
          completion_tokens: integer,
          total_tokens: integer
        }

  defstruct [:prompt_tokens, :completion_tokens, :total_tokens]

  use ExConstructor

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
