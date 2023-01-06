defmodule Openai.Files do
  alias Openai.Client.Files

  def call do
    Files.list()
  end

  def call(file_id) do
    Files.describe(file_id)
  end

  def upload(file) do
    Files.upload(file)
  end

  def delete(file_id) do
    Files.del(file_id)
  end
end
