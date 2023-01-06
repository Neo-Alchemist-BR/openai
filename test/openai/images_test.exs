defmodule Openai.ImagesTest do
  use ExUnit.Case

  import Openai.Mock
  alias Openai.Schemas.In.Images.Container

  setup do
    Application.put_env(:tesla, :adapter, Tesla.Mock)
  end

  describe "Create Image" do
    test "success - response format url" do
      success_expectations(:create_image)

      assert %Container{
               created: 1_234_567_890,
               data: [%Openai.Schemas.In.Images.Response{url: "http://...", b64_json: nil}]
             } = Openai.create_image(prompt: "A monkey eating banana", response_format: "url")
    end

    test "success - response format b64_json" do
      success_expectations(:create_image)

      assert %Container{
               created: 1_234_567_890,
               data: [%Openai.Schemas.In.Images.Response{url: nil, b64_json: "..."}]
             } =
               Openai.create_image(prompt: "A monkey eating banana", response_format: "b64_json")
    end
  end

  describe "Edit Image" do
    test "success" do
      success_expectations(:edit_image)

      assert %Container{
               created: 1_234_567_890,
               data: [%Openai.Schemas.In.Images.Response{url: "http://..."}]
             } =
               Openai.edit_image(
                 prompt: "A monkey eating banana",
                 image: "/home/sylon/Study/openai/Meu projeto.png"
               )
    end
  end

  describe "Create Image Variation" do
    test "success" do
      success_expectations(:create_image_variations)

      assert %Container{
               created: 1_234_567_890,
               data: [%Openai.Schemas.In.Images.Response{url: "http://..."}]
             } = Openai.create_image_variation(image: "/tmp/image/tree.png")
    end
  end
end
