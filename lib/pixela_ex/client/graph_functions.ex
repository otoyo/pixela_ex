defmodule PixelaEx.Client.GraphFunctions do
  @moduledoc """
  API Graph Functions for Pixela.
  """

  @doc """
  Create a new pixelation graph definition.

  ## Examples

      iex> PixelaEx.create_graph("a-know", "thisissecret", %{graph_id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu"})
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec create_graph(PixelaEx.username, PixelaEx.token, %{required(:graph_id) => PixelaEx.graph_id, required(:name) => PixelaEx.name, required(:unit) => PixelaEx.unit, required(:type) => PixelaEx.quantity_type, required(:color) => PixelaEx.color}) :: PixelaEx.http_result
  def create_graph(username, token, %{graph_id: graph_id, name: name, unit: unit, type: quantity_type, color: color}) do
    body = %{
      id:     graph_id,
      name:   name,
      unit:   unit,
      type:   quantity_type,
      color:  color
    }

    PixelaEx.Client.post "users/#{username}/graphs", [body: body, headers: ["X-USER-TOKEN": token]]
  end

  @doc """
  Get all predefined pixelation graph definitions.

  ## Examples

      iex> PixelaEx.get_graphs("a-know", "thisissecret")
      %HTTPotion.Response{status_code: 200, body: %{"graphs" => [%{"id" => "test-graph", "name" => "graph-name", "unit" => "commit", "type" => "int", "color" => "shibafu"}]}, headers: ...}

  """
  @spec get_graphs(PixelaEx.username, PixelaEx.token) :: PixelaEx.http_result
  def get_graphs(username, token) do
    PixelaEx.Client.get "users/#{username}/graphs", [headers: ["X-USER-TOKEN": token]]
  end

  @doc """
  Based on the registered information, express the graph in SVG format diagram.

  ## Examples

      iex> PixelaEx.get_graph("a-know", "test-graph")
      "https://pixe.la/v1/users/a-know/graphs/test-graph"

      iex> PixelaEx.get_graph("a-know", "test-graph", %{date: "20180331"})
      "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331"

  """
  @spec graph_url(PixelaEx.username, PixelaEx.graph_id, %{optional(:date) => PixelaEx.date, optional(:mode) => PixelaEx.mode}) :: String.t
  def graph_url(username, graph_id, param \\ %{}) when is_map(param) do
    query =
      ~w(date mode)a
      |> Enum.map(fn key ->
        case param[key] do
          nil -> nil
          val -> "#{key}=#{val}"
        end
      end)
      |> Enum.reject(&is_nil/1)
      |> Enum.join("&")
      |> case do
        ""  -> ""
        q   -> "?" <> q
      end

    PixelaEx.Client.api_endpoint() <> "users/#{username}/graphs/#{graph_id}" <> query
  end

  @doc """
  Update predefined pixelation graph definitions.

  ## Examples

      iex> PixelaEx.update_graph("a-know", "thisissecret", "test-graph", %{name: "graph-name", unit: "commit", color: "shibafu"})
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec update_graph(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id, %{required(:name) => PixelaEx.name, required(:unit) => PixelaEx.unit, required(:color) => PixelaEx.color}) :: PixelaEx.http_result
  def update_graph(username, token, graph_id, %{name: name, unit: unit, color: color}) do
    body = %{
      name:   name,
      unit:   unit,
      color:  color
    }

    PixelaEx.Client.put "users/#{username}/graphs/#{graph_id}", [body: body, headers: ["X-USER-TOKEN": token]]
  end

  @doc """
  Delete the predefined pixelation graph definition.

  ## Examples

      iex> PixelaEx.delete_graph("a-know", "thisissecret", "test-graph")
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec delete_graph(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id) :: PixelaEx.http_result
  def delete_graph(username, token, graph_id) do
    PixelaEx.Client.delete "users/#{username}/graphs/#{graph_id}", [headers: ["X-USER-TOKEN": token]]
  end
end
