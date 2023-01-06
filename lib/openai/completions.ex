defmodule Openai.Completions do
  alias Openai.Client.Completions
  alias Openai.Schemas.Out.Completions, as: Schema

  def fetch(params) do
    with completion <- Schema.new(params) do
      IO.inspect(completion)
      Completions.completions(completion)
    end
  end
end
