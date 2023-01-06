defmodule Openai.Search do
  alias Openai.Client
  alias Openai.Client.Search

  def call(engine_id, params) do
    Search.run(engine_id, params)
  end
end
