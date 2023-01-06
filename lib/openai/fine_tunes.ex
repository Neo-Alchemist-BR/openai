defmodule Openai.FineTunes do
  alias Openai.Client.FineTunes

  def call do
    FineTunes.list()
  end

  def call(fine_tune_id) do
    FineTunes.describe(fine_tune_id)
  end
end
