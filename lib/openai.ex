defmodule Openai do
  @moduledoc """
  Documentation for `Openai`.
  """

  alias Openai.{
    Answers,
    Classifications,
    Completions,
    Edits,
    Embeddings,
    Engines,
    Files,
    FineTunes,
    Images,
    Models,
    Search
  }

  # TODO Answer

  @doc """
  The endpoint first searches over provided documents or files to find relevant context. The relevant context is combined with the provided examples and question to create the prompt for completion.
  ## Example request
      Openai.answers(
        model: "curie",
        documents: ["Puppy A is happy.", "Puppy B is sad."],
        question: "which puppy is happy?",
        search_model: "ada",
        examples_context: "In 2017, U.S. life expectancy was 78.6 years.",
        examples: [["What is human life expectancy in the United States?", "78 years."]],
        max_tokens: 5
      )

  ## Example response
      {:ok,
        %{
        answers: ["puppy A."],
        completion: "cmpl-2kdRgXcoUfaAXxlPjmZXBT8AlKWfB",
        model: "curie:2020-05-03",
        object: "answer",
        search_model: "ada",
        selected_documents: [
          %{"document" => 0, "text" => "Puppy A is happy. "},
          %{"document" => 1, "text" => "Puppy B is sad. "}
        ]
        }
      }

    See: https://beta.Openai.com/docs/api-reference/answers

  """
  @deprecated """
  TODO: to detail this
  """
  defdelegate answers(params), to: Answers, as: :call

  # TODO Classifications
  @doc """
  It returns the most likely label for the query passed to the function.
  The function accepts as arguments a set of parameters that will be passed to the Classifications Openai api

  Given a query and a set of labeled examples, the model will predict the most likely label for the query. Useful as a drop-in replacement for any ML classification or text-to-label task.

  ## Example request
      Openai.classifications(
        examples: [
          ["A happy moment", "Positive"],
          ["I am sad.", "Negative"],
          ["I am feeling awesome", "Positive"]
        ],
        labels: ["Positive", "Negative", "Neutral"],
        query: "It is a raining day :(",
        search_model: "ada",
        model: "curie"
      )

  ## Example response
      {:ok,
        %{
          completion: "cmpl-2jIXZYg7Buyg1DDRYtozkre50TSMb",
          label: "Negative",
          model: "curie:2020-05-03",
          object: "classification",
          search_model: "ada",
          selected_examples: [
            %{"document" => 1, "label" => "Negative", "text" => "I am sad."},
            %{"document" => 0, "label" => "Positive", "text" => "A happy moment"},
            %{"document" => 2, "label" => "Positive", "text" => "I am feeling awesome"}
          ]
        }
      }

  See: https://beta.Openai.com/docs/api-reference/classifications for the complete list of parameters you can pass to the classifications function
  """
  defdelegate classifications(params), to: Classifications, as: :call

  # TODO Completions
  @doc """
  It returns one or more predicted completions given a prompt.
  The function accepts as arguments the set of parameters used by the Completions Openai api incluing the model

  ## Example request
      Openai.completions(
        model: "davinci", # model_id
        prompt: "once upon a time",
        max_tokens: 5,
        temperature: 1,
        ...
      )

  ## Example response
      {:ok, %{
        choices: [
          %{
            "finish_reason" => "length",
            "index" => 0,
            "logprobs" => nil,
            "text" => "\" thing we are given"
          }
        ],
        created: 1617147958,
        id: "...",
        model: "...",
        object: "text_completion"
        }
      }
  See: https://beta.Openai.com/docs/api-reference/completions/create for the complete list of parameters you can pass to the completions function
  """
  @spec completions(%{
          best_of: integer,
          echo: boolean,
          frequency_penalty: number,
          logit_bias: map,
          logprobs: nil | integer,
          max_tokens: integer,
          model: binary,
          n: integer,
          presence_penalty: number,
          prompt: binary | [binary],
          stop: nil | binary | [binary],
          stream: boolean,
          suffix: nil | binary,
          temperature: number,
          top_p: number,
          user: binary
        }) :: {:error, any} | {:ok, map()}
  defdelegate completions(params), to: Completions, as: :fetch

  # TODO Edits
  @spec edits(%{
          model: binary,
          instruction: binary,
          input: binary,
          temperature: number(),
          n: integer(),
          top_p: number()
        }) :: {:error, any} | {:ok, map()}
  defdelegate edits(params), to: Edits, as: :call

  # TODO Embeddings

  defdelegate create_embeddings(params), to: Embeddings, as: :call

  # TODO Engines

  @deprecated """
  use models instead
  """
  @doc """
  Retrieve specific engine info
  ## Example request
      Openai.engines("davinci")

  ## Example response
      {:ok, %{
        "id" => "davinci",
        "object" => "engine",
        "max_replicas": ...
      }
      }
  See: https://beta.Openai.com/docs/api-reference/engines/retrieve
  """
  defdelegate engines(engine_id), to: Engines, as: :call

  @deprecated """
  use models instead
  """
  @doc """
  Get the list of available engines
  ## Example request
      Openai.engines()

  ## Example response
      {:ok, %{
        "data" => [
          %{"id" => "davinci", "object" => "engine", "max_replicas": ...},
          ...,
          ...
        ]
      }
  See: https://beta.Openai.com/docs/api-reference/engines/list
  """
  defdelegate engines, to: Engines, as: :call

  # # TODO Files apis
  defdelegate file(file_id), to: Files, as: :call
  defdelegate files, to: Files, as: :call
  defdelegate upload_file(params), to: Files, as: :upload
  defdelegate delete_file(file_id), to: Files, as: :delete

  # TODO Finetunes

  @doc """
  List your organization's fine-tuning jobs
  ## Example request
      Openai.finetunes()

  ## Example response
      {:ok, %{
        "data" => [
          %{"created_at" => 1614807352, "fine_tuned_model" => "curie:ft-acmeco-2021-03-03-21-44-20", "model": ...},
          ...,
          ...
        ]
      }
  See: https://beta.Openai.com/docs/api-reference/fine-tunes/list
  """
  defdelegate finetunes, to: FineTunes, as: :call

  # TODO Finetunes by id
  @doc """
  Gets info about the fine-tune job.
  ## Example request
      Openai.finetunes("ft-AF1WoRqd3aJAHsqc9NY7iL8F")

  ## Example response
      {:ok, %{
        created_at: 1614807352,
        events: [
          %{
            "created_at" => 1614807352,
            "level" => "info",
            "message" => "Created fine-tune: ft-AF1WoRqd3aJAHsqc9NY7iL8F",
            "object" => "fine-tune-event"
          },
          %{
            "created_at" => 1614807360,
            "level" => "info",
            "message" => "Fine-tune costs $0.02",
            "object" => "fine-tune-event"
          },
          ...,
          ...
      }
  See: https://beta.Openai.com/docs/api-reference/fine-tunes/retrieve
  """
  defdelegate finetunes(finetune_id), to: FineTunes, as: :call

  # ! Image
  @spec create_image(map() | keyword()) :: map()
  @doc """
  This generates an image based on the given prompt.

  ## Example Request

  ``` elixir
  Openai.create_image([prompt: "A developer writing a test", size: "256x256"])
  ```

  ## Example Response
  ``` elixir
    {:ok, %{
      created: 1670341737,
      data: [
        %{
          "url" => "...Returned url"
        }
      ]
    }}
  ```
  See: https://beta.Openai.com/docs/api-reference/images/create for the complete list of parameters you can pass to the image creation function
  """
  defdelegate create_image(params), to: Images, as: :create

  @doc """
  This edits an image based on the given prompt.

  ## Example Request

  ```elixir
  Openai.edit_image(
    %{ "prompt" => "A developer writing a test", "size" => "256x256", "image" => "/home/developer/myImg.png"},
  )
  ```

  ## Example Response

  ```elixir
  {:ok, %{
    created: 1670341737,
    data: [
      %{
        "url" => "...Returned url"
      }
    ]
  }}
  ```
  See: https://beta.Openai.com/docs/api-reference/images/create-edit for the complete list of parameters you can pass to the image creation function
  """
  defdelegate edit_image(params), to: Images, as: :edit

  @doc """
  This generates an image based on the given prompt.

  ## Example Request

  ```elixir
  Openai.create_image_variation(
    %{"size" => "256x256", "image" => "/home/developer/myImg.png"}
  )
  ```

  ## Example Response

  ```elixir
  {:ok,
    %{
    created: 1670341737,
    data: [
        %{
          "url" => "...Returned url"
        }
      ]
    }}
  ```
  See: https://beta.Openai.com/docs/api-reference/images/create-variation for the complete list of parameters you can pass to the image creation function
  """
  @spec create_image_variation(keyword() | map()) :: {:error, any} | {:ok, map()}
  defdelegate create_image_variation(params), to: Images, as: :create_variation

  # !Models
  @spec list_models :: {:error, any} | {:ok, map()}
  defdelegate list_models(), to: Models, as: :call

  @spec describe_model(binary) :: {:error, any} | {:ok, map()}
  defdelegate describe_model(model), to: Models, as: :call

  # TODO Moderations

  # TODO Search
  @doc """
  It returns a rank of each document passed to the function, based on its semantic similarity to the passed query.
  The function accepts as arguments the engine_id and theset of parameters used by the Search Openai api

  ## Example request
      Openai.search(
        "babbage", #engine_id
        documents: ["White House", "hospital", "school"],
        query: "the president"
      )

  ## Example response
      {:ok,
        %{
          data: [
            %{"document" => 0, "object" => "search_result", "score" => 218.676},
            %{"document" => 1, "object" => "search_result", "score" => 17.797},
            %{"document" => 2, "object" => "search_result", "score" => 29.65}
          ],
          model: "...",
          object: "list"
        }}
  See: https://beta.Openai.com/docs/api-reference/searches for the complete list of parameters you can pass to the search function
  """
  @deprecated """
  TODO: explain
  """
  defdelegate search(engine_id, params), to: Search, as: :call
end
