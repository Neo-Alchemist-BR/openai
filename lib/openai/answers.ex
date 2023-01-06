defmodule Openai.Answers do
  alias Openai.Client.Answers

  def call(params) do
    Answers.run(params)
  end
end
