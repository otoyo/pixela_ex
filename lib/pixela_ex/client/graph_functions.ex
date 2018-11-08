defmodule PixelaEx.Client.GraphFunctions do
  @moduledoc """
  API Graph Functions for Pixela.
  """

  @doc """

  ## Examples

      iex> PixelaEx.Client.GraphFunctions.create_graph("a-know", "thisissecret", "test-graph", "graph-name", "commit", "int", "shibafu")
      {:post, ["users/a-know/graphs", [body: %{id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu"}, headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  def create_graph(username, token, graph_id, name, unit, type, color) do
    body = %{
      id: graph_id,
      name: name,
      unit: unit,
      type: type,
      color: color
    }

    {:post, ["users/#{username}/graphs", [body: body, headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """
  Get all predefined pixelation graph definitions.

  ## Examples

      iex> PixelaEx.Client.GraphFunctions.get_graphs("a-know", "thisissecret")
      {:get, ["users/a-know/graphs", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec get_graphs(PixelaEx.username(), PixelaEx.token()) :: PixelaEx.http_result()
  def get_graphs(username, token) do
    {:get, ["users/#{username}/graphs", [headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """
  Based on the registered information, express the graph in SVG format diagram.

  ## Examples

      iex> PixelaEx.Client.GraphFunctions.get_graph("a-know", "test-graph", [])
      {:get, ["users/a-know/graphs/test-graph", []]}

      iex> PixelaEx.Client.GraphFunctions.get_graph("a-know", "test-graph", date: "20180331", mode: "short")
      {:get, ["users/a-know/graphs/test-graph?date=20180331&mode=short", []]}

  """
  @spec get_graph(PixelaEx.username(), PixelaEx.graph_id(), date: PixelaEx.date(), mode: PixelaEx.mode()) :: String.t()
  def get_graph(username, graph_id, param) when is_list(param) do
    query =
      ~w(date mode)a
      |> Enum.map(fn key ->
        case Keyword.get(param, key) do
          nil -> nil
          val -> "#{key}=#{val}"
        end
      end)
      |> Enum.reject(&is_nil/1)
      |> Enum.join("&")
      |> case do
        "" -> ""
        q -> "?" <> q
      end

    {:get, ["users/#{username}/graphs/#{graph_id}" <> query, []]}
  end

  @doc """
  Update predefined pixelation graph definitions.

  ## Examples

      iex> PixelaEx.Client.GraphFunctions.update_graph("a-know", "thisissecret", "test-graph", name: "graph-name", unit: "commit", color: "shibafu", purge_cache_urls: ["https://camo.githubusercontent.com/xxx/xxxx"])
      {:put, ["users/a-know/graphs/test-graph", [body: %{name: "graph-name", unit: "commit", color: "shibafu", purge_cache_urls: ["https://camo.githubusercontent.com/xxx/xxxx"]}, headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec update_graph(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), purge_cache_urls: [String.t()]) ::
          PixelaEx.http_result()
  def update_graph(username, token, graph_id, param) when is_list(param) do
    body =
      for key <- ~w(name unit color purge_cache_urls)a,
          value = Keyword.get(param, key),
          into: Map.new() do
        {key, value}
      end

    {:put, ["users/#{username}/graphs/#{graph_id}", [body: body, headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """
  Delete the predefined pixelation graph definition.

  ## Examples

      iex> PixelaEx.Client.GraphFunctions.delete_graph("a-know", "thisissecret", "test-graph")
      {:delete, ["users/a-know/graphs/test-graph", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec delete_graph(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id()) :: PixelaEx.http_result()
  def delete_graph(username, token, graph_id) do
    {:delete, ["users/#{username}/graphs/#{graph_id}", [headers: ["X-USER-TOKEN": token]]]}
  end
end
