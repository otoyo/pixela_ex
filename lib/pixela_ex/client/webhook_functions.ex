defmodule PixelaEx.Client.WebhookFunctions do
  @moduledoc """
  API Webhook Functions for Pixela.
  """

  @doc """
  Create a new Webhook.

  ## Examples

      iex> PixelaEx.Client.WebhookFunctions.create_webhook("a-know", "thisissecret", "test-graph", "increment")
      {:post, ["users/a-know/webhooks", [body: %{graphID: "test-graph", type: "increment"}, headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec create_webhook(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), PixelaEx.countup_type()) ::
          PixelaEx.http_result()
  def create_webhook(username, token, graph_id, type) do
    body = %{
      graphID: graph_id,
      type: type
    }

    {:post, ["users/#{username}/webhooks", [body: body, headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """
  Get all predefined webhooks definitions.

  ## Examples

      iex> PixelaEx.Client.WebhookFunctions.get_webhooks("a-know", "thisissecret")
      {:get, ["users/a-know/webhooks", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec get_webhooks(PixelaEx.username(), PixelaEx.token()) :: PixelaEx.http_result()
  def get_webhooks(username, token) do
    {:get, ["users/#{username}/webhooks", [headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """
  Invoke the webhook registered in advance.

  ## Examples

      iex> PixelaEx.Client.WebhookFunctions.invoke_webhook("a-know", "<webhookHash>")
      {:post, ["users/a-know/webhooks/<webhookHash>", [headers: ["Content-Length": 0]]]}

  """
  @spec invoke_webhook(PixelaEx.username(), PixelaEx.webhook_hash()) :: PixelaEx.http_result()
  def invoke_webhook(username, webhook_hash) do
    {:post, ["users/#{username}/webhooks/#{webhook_hash}", [headers: ["Content-Length": 0]]]}
  end

  @doc """
  Delete the registered Webhook.

  ## Examples

      iex> PixelaEx.Client.WebhookFunctions.delete_webhook("a-know", "thisissecret", "<webhookHash>")
      {:delete, ["users/a-know/webhooks/<webhookHash>", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec delete_webhook(PixelaEx.username(), PixelaEx.token(), PixelaEx.webhook_hash()) :: PixelaEx.http_result()
  def delete_webhook(username, token, webhook_hash) do
    {:delete, ["users/#{username}/webhooks/#{webhook_hash}", [headers: ["X-USER-TOKEN": token]]]}
  end
end
