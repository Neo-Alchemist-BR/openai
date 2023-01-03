defmodule Openai.Schemas.In.Completions.Models.Permission do
  @type t :: %{}

  defstruct []

  use ExConstructor

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
