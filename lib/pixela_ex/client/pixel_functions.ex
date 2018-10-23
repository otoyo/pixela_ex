defmodule PixelaEx.Client.PixelFunctions do
  @moduledoc """
  API Pixel Functions for Pixela.
  """

  @doc """
  It records the quantity of the specified date as a "Pixel".

  ## Examples

      iex> PixelaEx.create_pixel("a-know", "thisissecret", "test-graph", %{date: "20180915", quantity: "5"})
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec create_pixel(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id, %{required(:date) => PixelaEx.date, required(:quantity) => PixelaEx.quantity}) :: PixelaEx.http_result
  def create_pixel(username, token, graph_id, %{date: date, quantity: quantity}) do
    body = %{
      date: date,
      quantity: quantity
    }

    PixelaEx.Client.post "users/#{username}/graphs/#{graph_id}", [body: body, headers: ["X-USER-TOKEN": token]]
  end

  @doc """
  Get registered quantity as "Pixel".

  ## Examples

      iex> PixelaEx.get_pixel("a-know", "thisissecret", "test-graph", "20180915")
      %HTTPotion.Response{status_code: 200, body: %{"quantity" => 5}, headers: ...}

  """
  @spec get_pixel(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id, PixelaEx.date) :: PixelaEx.http_result
  def get_pixel(username, token, graph_id, date) do
    PixelaEx.Client.get "users/#{username}/graphs/#{graph_id}/#{date}", [headers: ["X-USER-TOKEN": token]]
  end

  @doc """
  Update the quantity already registered as a "Pixel".

  ## Examples

      iex> PixelaEx.update_pixel("a-know", "thisissecret", "test-graph", "20180915", %{quantity: "7"})
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec update_pixel(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id, PixelaEx.date, %{required(:quantity) => PixelaEx.quantity}) :: PixelaEx.http_result
  def update_pixel(username, token, graph_id, date, %{quantity: quantity}) do
    body = %{
      quantity: quantity
    }

    PixelaEx.Client.put "users/#{username}/graphs/#{graph_id}/#{date}", [body: body, headers: ["X-USER-TOKEN": token]]
  end

  @doc """
  Increment quantity "Pixel" of the day (UTC).

  ## Examples

      iex> PixelaEx.increment_pixel("a-know", "thisissecret", "test-graph")
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec increment_pixel(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id) :: PixelaEx.http_result
  def increment_pixel(username, token, graph_id) do
    PixelaEx.Client.put "users/#{username}/graphs/#{graph_id}/increment", [headers: ["X-USER-TOKEN": token, "Content-Length": 0]]
  end

  @doc """
  Decrement quantity "Pixel" of the day (UTC).

  ## Examples

      iex> PixelaEx.decrement_pixel("a-know", "thisissecret", "test-graph")
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec decrement_pixel(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id) :: PixelaEx.http_result
  def decrement_pixel(username, token, graph_id) do
    PixelaEx.Client.put "users/#{username}/graphs/#{graph_id}/decrement", [headers: ["X-USER-TOKEN": token, "Content-Length": 0]]
  end

  @doc """
  Delete the registered "Pixel".

  ## Examples

      iex> PixelaEx.delete_pixel("a-know", "thisissecret", "test-graph", "20180915")
      %HTTPotion.Response{status_code: 200, body: %{"message" => "Success.", "isSuccess" => true}, headers: ...}

  """
  @spec delete_pixel(PixelaEx.username, PixelaEx.token, PixelaEx.graph_id, PixelaEx.date) :: PixelaEx.http_result
  def delete_pixel(username, token, graph_id, date) do
    PixelaEx.Client.delete "users/#{username}/graphs/#{graph_id}/#{date}", [headers: ["X-USER-TOKEN": token]]
  end
end
