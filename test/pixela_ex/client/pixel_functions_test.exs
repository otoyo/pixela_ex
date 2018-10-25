defmodule PixelaEx.Client.PixelFunctionsTest do
  use ExUnit.Case
  doctest PixelaEx.Client.PixelFunctions

  import Mock

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
end
