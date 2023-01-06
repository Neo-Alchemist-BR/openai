defmodule Openai.ConfigTest do
  use ExUnit.Case

  @application :openai

  setup_all do
    reset_env()
    on_exit(&reset_env/0)
  end

  defp reset_env() do
    Application.get_all_env(@application)
    |> Keyword.keys()
    |> Enum.each(&Application.delete_env(@application, &1))
  end
end
