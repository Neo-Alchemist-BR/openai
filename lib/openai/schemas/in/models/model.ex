defmodule Openai.Schemas.In.Models.Model do
  alias Openai.Schemas.In.Models.Permission
  defstruct [:created, :id, :object, :owned_by, :parent, :permission, :root]

  use ExConstructor

  def build(model) do
    model = new(model) |> IO.inspect()

    permissions =
      model.permission
      |> Stream.map(&Permission.new/1)
      |> Enum.to_list()

    %{model | permission: permissions}
  end
end
