defmodule PixelaEx.Client.WebhookFunctionsTest do
  use ExUnit.Case
  doctest PixelaEx.Client.WebhookFunctions

  import Mock

  test_with_mock "create_webhook", PixelaEx.Client,
    [post: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"hashString" => "<WebhookHashString>", "message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.create_webhook("a-know", "thisissecret", %{graph_id: "test-graph", type: "increment"})
    assert called PixelaEx.Client.post "users/a-know/webhooks", [body: %{graphID: "test-graph", type: "increment"}, headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "get_webhooks", PixelaEx.Client,
    [get: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"webhooks" => [%{"hashString" => "<WebhookHashString>", "message" => "Success.", "isSuccess" => true}]}} end] do
    PixelaEx.get_webhooks("a-know", "thisissecret")
    assert called PixelaEx.Client.get "users/a-know/webhooks", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "invoke_webhook", PixelaEx.Client,
    [post: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.invoke_webhook("a-know", "<webhookHash>")
    assert called PixelaEx.Client.post "users/a-know/webhooks/<webhookHash>", [headers: ["Content-Length": 0]]
  end

  test_with_mock "delete_webhook", PixelaEx.Client,
    [delete: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.delete_webhook("a-know", "thisissecret", "<webhookHash>")
    assert called PixelaEx.Client.delete "users/a-know/webhooks/<webhookHash>", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end
end
