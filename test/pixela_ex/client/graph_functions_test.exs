defmodule PixelaEx.Client.GraphFunctionsTest do
  use ExUnit.Case
  doctest PixelaEx.Client.GraphFunctions

  import Mock

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
end
