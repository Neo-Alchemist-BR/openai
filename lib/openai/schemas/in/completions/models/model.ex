defmodule Openai.Schemas.In.Completions.Models.Model do
  alias Openai.Schemas.In.Completions.Models.Permission

  @type t :: %{
          id: binary,
          object: binary,
          owned_by: binary,
          permission: list(Permission.t())
        }

  defstruct [:id, :object, :owned_by, :permission]

  use ExConstructor

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
