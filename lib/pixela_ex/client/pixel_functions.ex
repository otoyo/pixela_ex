defmodule PixelaEx.Client.PixelFunctions do
  @moduledoc """
  API Pixel Functions for Pixela.
  """

  @doc """

  ## Examples

      iex> PixelaEx.Client.PixelFunctions.create_pixel("a-know", "thisissecret", "test-graph", "20180915", "5")
      {:post, ["users/a-know/graphs/test-graph", [body: %{date: "20180915", quantity: "5"}, headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  def create_pixel(username, token, graph_id, date, quantity) do
    body = %{
      date: date,
      quantity: quantity
    }

    {:post, ["users/#{username}/graphs/#{graph_id}", [body: body, headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """

  ## Examples

      iex> PixelaEx.Client.PixelFunctions.get_pixel("a-know", "thisissecret", "test-graph", "20180915")
      {:get, ["users/a-know/graphs/test-graph/20180915", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  def get_pixel(username, token, graph_id, date) do
    {:get, ["users/#{username}/graphs/#{graph_id}/#{date}", [headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """

  ## Examples

      iex> PixelaEx.Client.PixelFunctions.update_pixel("a-know", "thisissecret", "test-graph", "20180915", "7")
      {:put, ["users/a-know/graphs/test-graph/20180915", [body: %{quantity: "7"}, headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  def update_pixel(username, token, graph_id, date, quantity) do
    body = %{
      quantity: quantity
    }

    {:put, ["users/#{username}/graphs/#{graph_id}/#{date}", [body: body, headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """

  ## Examples

      iex> PixelaEx.Client.PixelFunctions.increment_pixel("a-know", "thisissecret", "test-graph")
      {:put, ["users/a-know/graphs/test-graph/increment", [headers: ["X-USER-TOKEN": "thisissecret", "Content-Length": 0]]]}

  """
  def increment_pixel(username, token, graph_id) do
    {:put, ["users/#{username}/graphs/#{graph_id}/increment", [headers: ["X-USER-TOKEN": token, "Content-Length": 0]]]}
  end

  @doc """

  ## Examples

      iex> PixelaEx.Client.PixelFunctions.decrement_pixel("a-know", "thisissecret", "test-graph")
      {:put, ["users/a-know/graphs/test-graph/decrement", [headers: ["X-USER-TOKEN": "thisissecret", "Content-Length": 0]]]}

  """
  def decrement_pixel(username, token, graph_id) do
    {:put, ["users/#{username}/graphs/#{graph_id}/decrement", [headers: ["X-USER-TOKEN": token, "Content-Length": 0]]]}
  end

  @doc """
  Delete the registered "Pixel".

  ## Examples

      iex> PixelaEx.Client.PixelFunctions.delete_pixel("a-know", "thisissecret", "test-graph", "20180915")
      {:delete, ["users/a-know/graphs/test-graph/20180915", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec delete_pixel(PixelaEx.username(), PixelaEx.token(), PixelaEx.graph_id(), PixelaEx.date()) ::
          PixelaEx.http_result()
  def delete_pixel(username, token, graph_id, date) do
    {:delete, ["users/#{username}/graphs/#{graph_id}/#{date}", [headers: ["X-USER-TOKEN": token]]]}
  end
end
