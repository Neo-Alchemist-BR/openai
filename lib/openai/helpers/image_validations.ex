defmodule Openai.Helpers.ImageValidations do
  @spec validate_size(any) :: :ok | {:error, <<_::64, _::_*8>>}
  def validate_size(size) when size in ["256x256", "512x512", "1024x1024"], do: :ok

  def validate_size(size),
    do: {:error, "'#{size}' is not one of ['256x256', '512x512', '1024x1024'] - 'size'"}

  @spec validate_response_format(any) :: :ok | {:error, <<_::64, _::_*8>>}
  def validate_response_format(response_format) when response_format in ["url", "b64_json"],
    do: :ok

  def validate_response_format(response_format),
    do: {:error, "'#{response_format}' is not one of ['b64_json', 'url'] - 'response_format'"}
end
