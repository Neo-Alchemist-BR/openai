defmodule Openai.Edits do
  alias Openai.Client.Edits
  alias Openai.Schemas.Out.Edits.Create, as: Schema

  def call(params) do
    with edit <- Schema.new(params) do
      IO.inspect(edit)
      Edits.edit(edit)
    end
  end
end
