defmodule Openai.Schemas.In.Completions.Choice do
  @type t :: %{
          text: binary,
          index: integer,
          logprobs: integer,
          finish_reason: binary
        }

  defstruct [:text, :index, :logprobs, :finish_reason]

  use ExConstructor

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
