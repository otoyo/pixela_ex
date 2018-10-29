defmodule PixelaEx do
  @moduledoc """
  API Client for Pixela.
  """

  alias PixelaEx.Client.UserFunctions
  alias PixelaEx.Client.GraphFunctions
  alias PixelaEx.Client.PixelFunctions
  alias PixelaEx.Client.WebhookFunctions

  @typedoc "User name for Pixela"
  @type username :: String.t

  @typedoc "A token string used to authenticate as a user to be created"
  @type token :: String.t

  @typedoc "Whether you agree to the terms of service"
  @type agree_terms_of_service :: boolean()

  @typedoc "Whether you are not a minor or if you are a minor and you have the parental consent of using Pixela"
  @type not_minor :: boolean()

  @typedoc "A new authentication token"
  @type new_token :: String.t

  @typedoc "An ID for identifying the pixelation graph"
  @type graph_id :: String.t

  @typedoc "the name of the pixelation graph"
  @type name :: String.t

  @typedoc "A unit of the quantity recorded in the pixelation graph. Ex. commit, kilogram, calory."
  @type unit :: String.t

  @typedoc "The type of quantity to be handled in the graph. Only `int` or `float` are supported."
  @type quantity_type :: String.t

  @typedoc "The behavior when the Webhook is invoked. Only `increment` or `decrement` are supported."
  @type countup_type :: String.t

  @typedoc "The display color of the pixel in the pixelation graph. `shibafu`, `momiji`, `sora`, `ichou`, `ajisai` and `kuro` are supported as color kind."
  @type color :: String.t

  @typedoc "The date on which the quantity is to be recorded. It is specified in yyyyMMdd format."
  @type date :: String.t

  @typedoc "The graph display mode. As of October 23, 2018, support only short mode for displaying only about 90 days."
  @type mode :: String.t

  @typedoc "The quantity to be registered on the specified date."
  @type quantity :: String.t

  @typedoc "The hash string specifying the webhook"
  @type webhook_hash :: String.t

  @typedoc "HTTP response from HTTPotion"
  @type http_result :: HTTPotion.Response.t | %HTTPotion.AsyncResponse{} | %HTTPotion.ErrorResponse{}

  def apply({f, a}), do: apply(PixelaEx.Client, f, a)

  #
  # User Functions
  #
  def create_user(username, token, agree_terms_of_service, not_minor) do
    result =
      UserFunctions.create_user(username, token, agree_terms_of_service, not_minor)
      |> apply
    {:ok, result}
  end

  def update_user(username, token, new_token) do
    result =
      UserFunctions.update_user(username, token, new_token)
      |> apply
    {:ok, result}
  end

  def delete_user(username, token) do
    result =
      UserFunctions.delete_user(username, token)
      |> apply
    {:ok, result}
  end

  # Graph Functions
  #
  def create_graph(username, token, id, name, unit, type, color) do
    result =
      GraphFunctions.create_graph(username, token, id, name, unit, type, color)
      |> apply
    {:ok, result}
  end

  def get_graphs(username, token) do
   result =
     GraphFunctions.get_graphs(username, token)
     |> apply
   {:ok, result}
  end

  def get_graph(username, graph_id, param \\ []) do
    result =
      GraphFunctions.get_graph(username, graph_id, param)
      |> apply
    {:ok, result}
  end

  def update_graph(username, token, graph_id, param) do
    GraphFunctions.update_graph(username, token, graph_id, param)
    |> apply
  end

  def delete_graph(username, token, graph_id) do
    GraphFunctions.delete_graph(username, token, graph_id)
    |> apply
  end

  #
  # Pixel Functions
  #
  def create_pixel(username, token, graph_id, param) do
    PixelFunctions.create_pixel(username, token, graph_id, param)
    |> apply
  end

  def get_pixel(username, token, graph_id, date) do
    PixelFunctions.get_pixel(username, token, graph_id, date)
    |> apply
  end

  def update_pixel(username, token, graph_id, date, param) do
    PixelFunctions.update_pixel(username, token, graph_id, date, param)
    |> apply
  end

  def increment_pixel(username, token, graph_id) do
    PixelFunctions.increment_pixel(username, token, graph_id)
    |> apply
  end

  def decrement_pixel(username, token, graph_id) do
    PixelFunctions.decrement_pixel(username, token, graph_id)
    |> apply
  end

  def delete_pixel(username, token, graph_id, date) do
    PixelFunctions.delete_pixel(username, token, graph_id, date)
    |> apply
  end

  #
  # Webhook Functions
  #
  def create_webhook(username, token, param) do
    WebhookFunctions.create_webhook(username, token, param)
    |> apply
  end

  def get_webhooks(username, token) do
    WebhookFunctions.get_webhooks(username, token)
    |> apply
  end

  def invoke_webhook(username, webhook_hash) do
    WebhookFunctions.invoke_webhook(username, webhook_hash)
    |> apply
  end

  def delete_webhook(username, token, webhook_hash) do
    WebhookFunctions.delete_webhook(username, token, webhook_hash)
    |> apply
  end
end
