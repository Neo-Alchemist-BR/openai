defmodule Openai.Client.Engines do
  @moduledoc """
  Deprecated - Use Openai.Client.Models instead
  """

  alias Openai.Client

  @url "/v1/engines"

  @spec list :: {:error, any} | {:ok, map()}
  @deprecated """
  Use Openai.Client.Models instead
  """
  def list, do: Client.call(@url)

  @spec describe(binary) :: {:error, any} | {:ok, map()}
  @deprecated """
  Use Openai.Client.Models instead
  """
  def describe(engine_id), do: Client.get("#{@url}/#{engine_id}")
end
