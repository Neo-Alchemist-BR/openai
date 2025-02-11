defmodule Openai.Schemas.Out.Completions.Completions do
  @moduledoc """
  Given a prompt, the model will return one or more predicted completions, and can also return the probabilities of alternative tokens at each position.
  """

  @typedoc """
    - Required * \n
  ID of the model to use. You can use the List models API to see all of your available models, or see our Model overview for descriptions of them.
  """

  @type model :: binary()

  @typedoc """
    - Optional
    - Defaults to <|endoftext|> \n
  The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.

  Note that <|endoftext|> is the document separator that the model sees during training, so if a prompt is not specified the model will generate as if from the beginning of a new document.
  """

  @type prompt :: binary() | list(binary())

  @typedoc """
    - Defaults to null \n
  The suffix that comes after a completion of inserted text.
  """

  @type suffix :: binary() | nil

  @typedoc """
    - Optional
    - Defaults to 16 \n
  The maximum number of tokens to generate in the completion.

  The token count of your prompt plus max_tokens cannot exceed the model's context length. Most models have a context length of 2048 tokens (except for the newest models, which support 4096).
  """

  @type max_tokens :: integer()

  @typedoc """
    - Optional
    - Defaults to 1 \n
  What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.

  We generally recommend altering this or top_p but not both.
  """

  @type temperature :: number()

  @typedoc """
    - Optional
    - Defaults to 1 \n
  An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.

  We generally recommend altering this or temperature but not both.
  """

  @type top_p :: number()

  @typedoc """
    - Optional
    - Defaults to 1 \n
  How many completions to generate for each prompt.

  Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.
  """

  @type n :: integer()

  @typedoc """
    - Optional
    - Defaults to false \n
  Whether to stream back partial progress. If set, tokens will be sent as data-only server-sent events as they become available, with the stream terminated by a data: [DONE] message.
  """

  @type stream :: boolean()

  @typedoc """
    - Optional
    - Defaults to null \n
  Include the log probabilities on the logprobs most likely tokens, as well the chosen tokens. For example, if logprobs is 5, the API will return a list of the 5 most likely tokens. The API will always return the logprob of the sampled token, so there may be up to logprobs+1 elements in the response.

  The maximum value for logprobs is 5. If you need more than this, please contact us through our Help center and describe your use case.
  """

  @type logprobs :: integer() | nil

  @typedoc """
    - Optional
    - Defaults to false \n
  Echo back the prompt in addition to the completion
  """

  @type echo :: boolean()

  @typedoc """
    - Optional
    - Defaults to null \n
  Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
  """

  @type stop :: binary() | list(binary()) | nil

  @typedoc """
    - Optional
    - Defaults to 0 \n
  Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.

  See more information about frequency and presence penalties.
  """

  @type presence_penalty :: number()

  @typedoc """
    - Optional
    - Defaults to 0 \n
  Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.

  See more information about frequency and presence penalties.
  """

  @type frequency_penalty :: number()

  @typedoc """
    - Optional
    - Defaults to 1 \n
  Generates best_of completions server-side and returns the "best" (the one with the highest log probability per token). Results cannot be streamed.

  When used with n, best_of controls the number of candidate completions and n specifies how many to return – best_of must be greater than n.

  Note: Because this parameter generates many completions, it can quickly consume your token quota. Use carefully and ensure that you have reasonable settings for max_tokens and stop.
  """

  @type best_of :: integer()

  @typedoc """
    - Optional
    - Defaults to null
    - Modify the likelihood of specified tokens appearing in the completion. \n

  Accepts a json object that maps tokens (specified by their token ID in the GPT tokenizer) to an associated bias value from -100 to 100. You can use this tokenizer tool (which works for both GPT-2 and GPT-3) to convert text to token IDs. Mathematically, the bias is added to the logits generated by the model prior to sampling. The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token.

  As an example, you can pass {"50256": -100} to prevent the <|endoftext|> token from being generated.
  """

  @type logit_bias :: map()

  @typedoc """
    - Optional \n
  A unique identifier representing your end-user, which can help Openai to monitor and detect abuse. Learn more.
  """

  @type user :: binary()

  @type t :: %{
          best_of: best_of,
          echo: echo,
          frequency_penalty: frequency_penalty,
          logit_bias: logit_bias,
          logprobs: logprobs,
          max_tokens: max_tokens,
          model: model,
          n: n,
          presence_penalty: presence_penalty,
          prompt: prompt,
          stop: stop,
          stream: stream,
          suffix: suffix,
          temperature: temperature,
          top_p: top_p,
          user: user
        }

  @nullable_fields ~w(stop suffix logprobs)a

  defstruct [
              prompt: "<|endoftext|>",
              logit_bias: %{},
              best_of: 1,
              presence_penalty: 0,
              frequency_penalty: 0,
              temperature: 1,
              top_p: 1,
              n: 1,
              model: "text-davinci-003",
              max_tokens: 16,
              stream: false,
              echo: false,
              user: ""
            ] ++ @nullable_fields

  use Vex.Struct
  use ExConstructor

  validates(:prompt, &is_binary/1)
  validates(:model, presence: true, by: &is_binary/1)
  validates(:logit_bias, by: &is_map/1)

  validates(:frequency_penalty,
    number: [greater_than_or_equal_to: -2.0, less_than_or_equal_to: 2.0]
  )

  @spec set_max_tokens(__MODULE__.t(), max_tokens() | any()) :: __MODULE__.t()
  def set_max_tokens(completion, max_tokens) when max_tokens in 0..2_048 do
    %{completion | max_tokens: max_tokens}
  end

  def set_max_tokens(completion, _max_tokens), do: completion

  @spec set_logprobs(__MODULE__.t(), logprobs() | nil) :: __MODULE__.t()
  def set_logprobs(completion, nil), do: %{completion | logprobs: nil}

  def set_logprobs(completion, logprobs) when is_integer(logprobs) and logprobs < 5,
    do: %{completion | logprobs: logprobs}

  def set_logprobs(completion, _logprobs), do: %{completion | logprobs: 5}

  @spec set_presence_penalty(__MODULE__.t(), presence_penalty) :: __MODULE__.t()
  def set_presence_penalty(completion, presence_penalty) when presence_penalty in -2..2,
    do: %{completion | presence_penalty: presence_penalty}

  def set_presence_penalty(completion, _presence_penalty), do: completion

  @spec set_frequency_penalty(__MODULE__.t(), frequency_penalty) :: __MODULE__.t()
  def set_frequency_penalty(completion, frequency_penalty) when frequency_penalty in -2..2,
    do: %{completion | frequency_penalty: frequency_penalty}

  def set_frequency_penalty(completion, _frequency_penalty), do: completion

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(struct, opts) do
      struct
      |> Map.from_struct()
      |> Jason.Encode.map(opts)
    end
  end
end
