defmodule Openai.Client do
  alias Openai.Client.{Image}

  defmacro __using__(_opts) do
    quote do
      use Tesla

      plug(Tesla.Middleware.BaseUrl, "https://api.openai.com")

      plug(Tesla.Middleware.Headers, [
        {"authorization", "Bearer " <> Application.get_env(:openai, :api_key)}
      ])

      plug(Tesla.Middleware.JSON)
    end
  end

  defdelegate create_image(payload), to: Image, as: :create
  defdelegate create_image_variation(payload), to: Image, as: :create_variation
  defdelegate edit_image(payload), to: Image, as: :edit
end
