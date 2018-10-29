defmodule PixelaExTest do
  use ExUnit.Case

  import Mock

  test_with_mock "create_user", PixelaEx.Client,
    [post: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.create_user(%{username: "a-know", token: "thisissecret", agree_terms_of_service: true, not_minor: true})
    assert called PixelaEx.Client.post "users", [body: %{username: "a-know", token: "thisissecret", agreeTermsOfService: true, notMinor: true}]
  end

  test_with_mock "update_user", PixelaEx.Client,
    [put: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.update_user("a-know", "thisissecret", %{new_token: "thisissecret"})
    assert called PixelaEx.Client.put "users/a-know", [body: %{new_token: "thisissecret"}, headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "delete_user", PixelaEx.Client,
    [delete: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.delete_user("a-know", "thisissecret")
    assert called PixelaEx.Client.delete "users/a-know", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "create_graph", PixelaEx.Client,
    [post: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.create_graph("a-know", "thisissecret", %{graph_id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu"})
    assert called PixelaEx.Client.post "users/a-know/graphs", [body: %{id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu"}, headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "get_graphs", PixelaEx.Client,
    [get: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"graphs" => [%{"id" => "test-graph", "name" => "graph-name", "unit" => "commit", "type" => "int", "color" => "shibafu"}]}} end] do
    PixelaEx.get_graphs("a-know", "thisissecret")
    assert called PixelaEx.Client.get "users/a-know/graphs", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test "graph_url" do
    #assert PixelaEx.graph_url("a-know", "test-graph") == "https://pixe.la/v1/users/a-know/graphs/test-graph"
    assert PixelaEx.graph_url("a-know", "test-graph", %{date: "20180331"}) == "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331"
    assert PixelaEx.graph_url("a-know", "test-graph", %{date: "20180331", mode: "short"}) == "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331&mode=short"
  end

  test_with_mock "update_graph", PixelaEx.Client,
    [put: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.update_graph("a-know", "thisissecret", "test-graph", %{name: "graph-name", unit: "commit", color: "shibafu"})
    assert called PixelaEx.Client.put "users/a-know/graphs/test-graph", [body: %{name: "graph-name", unit: "commit", color: "shibafu"}, headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "delete_graph", PixelaEx.Client,
    [delete: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.delete_graph("a-know", "thisissecret", "test-graph")
    assert called PixelaEx.Client.delete "users/a-know/graphs/test-graph", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "create_pixel", PixelaEx.Client,
    [post: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.create_pixel("a-know", "thisissecret", "test-graph", %{date: "20180915", quantity: "5"})
    assert called PixelaEx.Client.post "users/a-know/graphs/test-graph", [body: %{date: "20180915", quantity: "5"}, headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "get_pixel", PixelaEx.Client,
    [get: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"quantity" => 5}} end] do
    PixelaEx.get_pixel("a-know", "thisissecret", "test-graph", "20180915")
    assert called PixelaEx.Client.get "users/a-know/graphs/test-graph/20180915", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "update_pixel", PixelaEx.Client,
    [put: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.update_pixel("a-know", "thisissecret", "test-graph", "20180915", %{quantity: "7"})
    assert called PixelaEx.Client.put "users/a-know/graphs/test-graph/20180915", [body: %{quantity: "7"}, headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "increment_pixel", PixelaEx.Client,
    [put: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.increment_pixel("a-know", "thisissecret", "test-graph")
    assert called PixelaEx.Client.put "users/a-know/graphs/test-graph/increment", [headers: ["X-USER-TOKEN": "thisissecret", "Content-Length": 0]]
  end

  test_with_mock "decrement_pixel", PixelaEx.Client,
    [put: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.decrement_pixel("a-know", "thisissecret", "test-graph")
    assert called PixelaEx.Client.put "users/a-know/graphs/test-graph/decrement", [headers: ["X-USER-TOKEN": "thisissecret", "Content-Length": 0]]
  end

  test_with_mock "delete_pixel", PixelaEx.Client,
    [delete: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.delete_pixel("a-know", "thisissecret", "test-graph", "20180915")
    assert called PixelaEx.Client.delete "users/a-know/graphs/test-graph/20180915", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end

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
