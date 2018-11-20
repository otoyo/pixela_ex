defmodule PixelaEx do
  @moduledoc """
  API Client for Pixela.
  """

  alias PixelaEx.Client.UserFunctions
  alias PixelaEx.Client.GraphFunctions
  alias PixelaEx.Client.PixelFunctions
  alias PixelaEx.Client.WebhookFunctions

  @typedoc """
  User name for Pixela

  Validation rule: `[a-z][a-z0-9-]{1,32}`
  """
  @type username :: String.t()

  @typedoc """
  A token string used to authenticate as a user to be created

  The token string is hashed and saved.

  Validation rule: `[ -~]{8,128}`
  """
  @type token :: String.t()

  @typedoc """
  Whether you agree to the terms of service

  Please see: [Terms of service - Japanese version](https://github.com/a-know/Pixela/wiki/%E5%88%A9%E7%94%A8%E8%A6%8F%E7%B4%84%EF%BC%88Terms-of-Service-Japanese-Version%EF%BC%89) / [Terms of service - English version](https://github.com/a-know/Pixela/wiki/Terms-of-Service)
  """
  @type agree_terms_of_service :: boolean()

  @typedoc """
  Whether you are not a minor or if you are a minor and you have the parental consent of using Pixela
  """
  @type not_minor :: boolean()

  @typedoc """
  A new authentication token

  The token string is hashed and saved.

  Validation rule: [ -~]{8,128}
  """
  @type new_token :: String.t()

  @typedoc """
  An ID for identifying the pixelation graph

  Validation rule: ^[a-z][a-z0-9-]{1,16}
  """
  @type graph_id :: String.t()

  @typedoc """
  The name of the pixelation graph
  """
  @type name :: String.t()

  @typedoc """
  A unit of the quantity recorded in the pixelation graph

  Ex. commit, kilogram, calory.
  """
  @type unit :: String.t()

  @typedoc """
  The type of quantity to be handled in the graph

  Only `int` or `float` are supported.
  """
  @type quantity_type :: String.t()

  @typedoc "The behavior when the Webhook is invoked. Only `increment` or `decrement` are supported."
  @type countup_type :: String.t()

  @typedoc """
  The display color of the pixel in the pixelation graph

  `shibafu` (green), `momiji` (red), `sora` (blue), `ichou` (yellow), `ajisai` (purple) and `kuro` (black) are supported as color kind.
  """
  @type color :: String.t()

  @typedoc "The date on which the quantity is to be recorded. It is specified in yyyyMMdd format."
  @type date :: String.t()

  @typedoc "The graph display mode. As of October 23, 2018, support only short mode for displaying only about 90 days."
  @type mode :: String.t()

  @typedoc "The quantity to be registered on the specified date."
  @type quantity :: String.t()

  @typedoc "The hash string specifying the webhook"
  @type webhook_hash :: String.t()

  @typedoc """
  HTTP response from HTTPotion
  """
  @type http_result :: {:ok, HTTPotion.Response.t()} | {:ok, %HTTPotion.AsyncResponse{}} | {:ok, %HTTPotion.ErrorResponse{}}

  @doc false
  def apply({f, a}), do: apply(PixelaEx.Client, f, a)

  #
  # User Functions
  #

  @doc """
  Create a new Pixela user.

  See also [Create a User](https://docs.pixe.la/#/post-user)
  """
  @spec create_user(username(), token(), agree_terms_of_service(), not_minor()) :: http_result()
  def create_user(username, token, agree_terms_of_service, not_minor) do
    result =
      UserFunctions.create_user(username, token, agree_terms_of_service, not_minor)
      |> apply

    {:ok, result}
  end

  @doc """
  Updates the authentication token for the specified user.

  See also [Update a User](https://docs.pixe.la/#/put-user)
  """
  @spec update_user(username(), token(), new_token()) :: http_result()
  def update_user(username, token, new_token) do
    result =
      UserFunctions.update_user(username, token, new_token)
      |> apply

    {:ok, result}
  end

  @doc """
  Deletes the specified registered user.

  See also [Delete a User](https://docs.pixe.la/#/delete-user)
  """
  @spec delete_user(username(), token()) :: http_result()
  def delete_user(username, token) do
    result =
      UserFunctions.delete_user(username, token)
      |> apply

    {:ok, result}
  end

  #
  # Graph Functions
  #

  @doc """
  Create a new pixelation graph definition.

  See also [Create a graph](https://docs.pixe.la/#/post-graph)
  """
  @spec create_graph(
          username(),
          token(),
          graph_id(),
          name(),
          unit(),
          quantity_type(),
          color()
        ) :: http_result()
  def create_graph(username, token, id, name, unit, type, color) do
    result =
      GraphFunctions.create_graph(username, token, id, name, unit, type, color)
      |> apply

    {:ok, result}
  end

  @doc """
  Get all predefined pixelation graph definitions.

  See also [Get graph definitions](https://docs.pixe.la/#/get-graph)
  """
  @spec get_graphs(username(), token()) :: http_result()
  def get_graphs(username, token) do
    result =
      GraphFunctions.get_graphs(username, token)
      |> apply

    {:ok, result}
  end

  @doc """
  Based on the registered information, express the graph in SVG format diagram.
  """
  @spec get_graph(PixelaEx.username(), PixelaEx.graph_id(), date: PixelaEx.date(), mode: PixelaEx.mode()) :: String.t()
  def get_graph(username, graph_id, param \\ []) do
    result =
      GraphFunctions.get_graph(username, graph_id, param)
      |> apply

    {:ok, result}
  end

  @doc """
  Update predefined pixelation graph definitions.
  """
  @spec update_graph(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), purge_cache_urls: [String.t()]) ::
          PixelaEx.http_result()
  def update_graph(username, token, graph_id, param) do
    result =
      GraphFunctions.update_graph(username, token, graph_id, param)
      |> apply

    {:ok, result}
  end

  @doc """
  Delete the predefined pixelation graph definition.
  """
  @spec delete_graph(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id()) :: PixelaEx.http_result()
  def delete_graph(username, token, graph_id) do
    result =
      GraphFunctions.delete_graph(username, token, graph_id)
      |> apply

    {:ok, result}
  end

  #
  # Pixel Functions
  #

  @doc """
  It records the quantity of the specified date as a "Pixel".
  """
  @spec create_pixel(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), PixelaEx.date(), PixelaEx.quantity()) ::
          PixelaEx.http_result()
  def create_pixel(username, token, graph_id, date, quantity) do
    result =
      PixelFunctions.create_pixel(username, token, graph_id, date, quantity)
      |> apply

    {:ok, result}
  end

  @doc """
  Get registered quantity as "Pixel".
  """
  @spec get_pixel(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), PixelaEx.date()) :: PixelaEx.http_result()
  def get_pixel(username, token, graph_id, date) do
    result =
      PixelFunctions.get_pixel(username, token, graph_id, date)
      |> apply

    {:ok, result}
  end

  @doc """
  Update the quantity already registered as a "Pixel".
  """
  @spec update_pixel(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), PixelaEx.date(), PixelaEx.quantity()) ::
          PixelaEx.http_result()
  def update_pixel(username, token, graph_id, date, param) do
    result =
      PixelFunctions.update_pixel(username, token, graph_id, date, param)
      |> apply

    {:ok, result}
  end

  @doc """
  Increment quantity "Pixel" of the day (UTC).
  """
  @spec increment_pixel(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id()) :: PixelaEx.http_result()
  def increment_pixel(username, token, graph_id) do
    result =
      PixelFunctions.increment_pixel(username, token, graph_id)
      |> apply

    {:ok, result}
  end

  @doc """
  Decrement quantity "Pixel" of the day (UTC).
  """
  @spec decrement_pixel(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id()) :: PixelaEx.http_result()
  def decrement_pixel(username, token, graph_id) do
    result =
      PixelFunctions.decrement_pixel(username, token, graph_id)
      |> apply

    {:ok, result}
  end

  @doc """
  Delete the registered "Pixel".
  """
  @spec delete_pixel(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), PixelaEx.date()) ::
          PixelaEx.http_result()
  def delete_pixel(username, token, graph_id, date) do
    result =
      PixelFunctions.delete_pixel(username, token, graph_id, date)
      |> apply

    {:ok, result}
  end

  #
  # Webhook Functions
  #

  @doc """
  Create a new Webhook.
  """
  @spec create_webhook(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), PixelaEx.countup_type()) ::
          PixelaEx.http_result()
  def create_webhook(username, token, graph_id, type) do
    result =
      WebhookFunctions.create_webhook(username, token, graph_id, type)
      |> apply

    {:ok, result}
  end

  @doc """
  Get all predefined webhooks definitions.
  """
  @spec get_webhooks(PixelaEx.username(), PixelaEx.token()) :: PixelaEx.http_result()
  def get_webhooks(username, token) do
    result =
      WebhookFunctions.get_webhooks(username, token)
      |> apply

    {:ok, result}
  end

  @doc """
  Invoke the webhook registered in advance.
  """
  @spec invoke_webhook(PixelaEx.username(), PixelaEx.webhook_hash()) :: PixelaEx.http_result()
  def invoke_webhook(username, webhook_hash) do
    result =
      WebhookFunctions.invoke_webhook(username, webhook_hash)
      |> apply

    {:ok, result}
  end

  @doc """
  Delete the registered Webhook.
  """
  @spec delete_webhook(PixelaEx.username(), PixelaEx.token(), PixelaEx.webhook_hash()) :: PixelaEx.http_result()
  def delete_webhook(username, token, webhook_hash) do
    result =
      WebhookFunctions.delete_webhook(username, token, webhook_hash)
      |> apply

    {:ok, result}
  end
end
