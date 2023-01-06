defmodule Openai.Mock do
  import Tesla.Mock

  def success_expectations(:create_image) do
    mock(fn %Tesla.Env{
              method: :post,
              url: "https://api.openai.com/v1/images/generations",
              body: body
            } ->
      image_response(body)
    end)
  end

  def success_expectations(:create_image_variations) do
    mock(fn %Tesla.Env{
              method: :post,
              url: "https://api.openai.com/v1/images/variations",
              body: body
            } ->
      body.parts
      |> Enum.find(&(&1.dispositions == [name: "response_format"]))
      |> IO.inspect()
      |> image_response()
    end)
  end

  def success_expectations(:edit_image) do
    mock(fn %Tesla.Env{method: :post, url: "https://api.openai.com/v1/images/edits", body: body} ->
      body.parts
      |> Enum.find(&(&1.dispositions == [name: "response_format"]))
      |> image_response()
    end)
  end

  def success_expectations(_) do
    mock(fn %Tesla.Env{method: :post, url: url, body: body} = env ->
      IO.inspect(url)
      IO.inspect(env)

      :ok
    end)
  end

  defp image_response(%{dispositions: [name: "url"]}) do
    do_image_response(%{"url" => "http://..."})
  end

  defp image_response(%{dispositions: [name: "b64_json"]}) do
    do_image_response(%{"b64_json" => "..."})
  end

  defp image_response(body) do
    if(Regex.match?(~r/\"response_format\":\"url\"/, body),
      do: image_response("url"),
      else: image_response("b64_json")
    )
    |> do_image_response()
  end

  defp do_image_response(data) do
    %Tesla.Env{
      status: 200,
      body: %{"created" => 1_234_567_890, "data" => [data]}
    }
  end
end
