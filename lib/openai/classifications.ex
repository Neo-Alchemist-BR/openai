defmodule Openai.Classifications do
  alias Openai.Client.Classifications

  def call(params) do
    Classifications.create(params)
  end
end
