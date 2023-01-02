defmodule Openai.Client.Image do
  use Openai.Client

  def create(payload) do
    path = "/v1/images/generations"
    post(path, payload)
  end

  def create_variation(payload) do
    path = "/v1/images/variations"
    post(path, payload)
  end

  def edit(payload) do
    path = "/v1/images/edits"
    post(path, payload)
  end
end
