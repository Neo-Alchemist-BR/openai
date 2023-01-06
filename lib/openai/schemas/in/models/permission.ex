defmodule Openai.Schemas.In.Models.Permission do
  defstruct [
    :allow_create_engine,
    :allow_fine_tuning,
    :allow_logprobs,
    :allow_sampling,
    :allow_search_indices,
    :allow_view,
    :created,
    :group,
    :id,
    :is_blocking,
    :object,
    :organization
  ]

  use ExConstructor
end
