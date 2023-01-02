defmodule Openai.Client.Models do
  use Openai.Client

  def list_models, do: get("/v1/models")
  def get_model(model_id), do: get("/v1/models/#{model_id}")
end
