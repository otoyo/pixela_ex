defmodule PixelaEx.Client.WebhookFunctions do
  @moduledoc """
  API Webhook Functions for Pixela.
  """

  defmacro __using__(_) do
    quote do

      @doc """
      Create a new Webhook.

      ## Examples

          iex> PixelaEx.create_webhook("a-know", "thisissecret", %{graph_id: "test-graph", type: "increment"})
          %HTTPotion.Response{status_code: 200, body: %{"hashString" => "<WebhookHashString>", "message" => "Success.", "isSuccess" => true}, headers: ...}

      """
      @spec create_webhook(username, token, %{required(:graph_id) => graph_id, required(:type) => countup_type}) :: http_result
      def create_webhook(username, token, %{graph_id: graph_id, type: countup_type}) do
        body = %{
          graphID:  graph_id,
          type:     countup_type
        }

        PixelaEx.Client.post "users/#{username}/webhooks", [body: body, headers: ["X-USER-TOKEN": token]]
      end

      @doc """
      Get all predefined webhooks definitions.

      ## Examples

          iex> PixelaEx.get_webhooks("a-know", "thisissecret")
          %HTTPotion.Response{status_code: 200, body: %{"webhooks" => [%{"hashString" => "<WebhookHashString>", "message" => "Success.", "isSuccess" => true}]}, headers: ...}

      """
      @spec get_webhooks(username, token) :: http_result
      def get_webhooks(username, token) do
        PixelaEx.Client.get "users/#{username}/webhooks", [headers: ["X-USER-TOKEN": token]]
      end

      @doc """
      Invoke the webhook registered in advance.

      ## Examples

          iex> PixelaEx.invoke_webhook("a-know", "<webhookHash>")
          %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

      """
      @spec invoke_webhook(username, webhook_hash) :: http_result
      def invoke_webhook(username, webhook_hash) do
        PixelaEx.Client.post "users/#{username}/webhooks/#{webhook_hash}", [headers: ["Content-Length": 0]]
      end

      @doc """
      Delete the registered Webhook.

      ## Examples

          iex> PixelaEx.delete_webhook("a-know", "thisissecret", "<webhookHash>")
          %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

      """
      @spec delete_webhook(username, token, webhook_hash) :: http_result
      def delete_webhook(username, token, webhook_hash) do
        PixelaEx.Client.delete "users/#{username}/webhooks/#{webhook_hash}", [headers: ["X-USER-TOKEN": token]]
      end
    end
  end
end
