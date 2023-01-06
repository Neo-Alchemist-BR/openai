defmodule Openai.Client.Search do
  alias Openai.Client

  @url "/v1/engines"

  @deprecated """
  use models completions instead
  """
  def run(engine_id, params), do: Client.call("#{@url}/#{engine_id}/search", params)
end
