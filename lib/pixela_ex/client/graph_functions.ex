defmodule PixelaEx.Client.GraphFunctions do
  @moduledoc """
  API Graph Functions for Pixela.
  """

  defmacro __using__(_) do
    quote do

      @doc """
      Create a new pixelation graph definition.

      ## Examples

          iex> PixelaEx.create_graph("a-know", "thisissecret", %{graph_id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu"})
          %{"message" => "Success.", "isSuccess" => true}

      """
      @spec create_graph(username, token, %{required(:graph_id) => graph_id, required(:name) => name, required(:unit) => unit, required(:type) => quantity_type, required(:color) => color}) :: http_result
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
          %{"graphs" => [%{"id" => "test-graph", "name" => "graph-name", "unit" => "commit", "type" => "int", "color" => "shibafu"}]}

      """
      @spec get_graphs(username, token) :: http_result
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
      @spec graph_url(username, graph_id, %{optional(:date) => date}) :: String.t
      def graph_url(username, graph_id, param \\ %{}) when is_map(param) do
        query = case param[:date] do
          nil   -> ""
          date  -> "?date=#{date}"
        end

        PixelaEx.Client.api_endpoint() <> "users/#{username}/graphs/#{graph_id}" <> query
      end

      @doc """
      Update predefined pixelation graph definitions.

      ## Examples

          iex> PixelaEx.update_graph("a-know", "thisissecret", "test-graph", %{name: "graph-name", unit: "commit", color: "shibafu"})
          %{"message" => "Success.", "isSuccess" => true}

      """
      @spec update_graph(username, token, graph_id, %{required(:name) => name, required(:unit) => unit, required(:color) => color}) :: http_result
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
          %{"message" => "Success.", "isSuccess" => true}

      """
      @spec delete_graph(username, token, graph_id) :: http_result
      def delete_graph(username, token, graph_id) do
        PixelaEx.Client.delete "users/#{username}/graphs/#{graph_id}", [headers: ["X-USER-TOKEN": token]]
      end
    end
  end
end
