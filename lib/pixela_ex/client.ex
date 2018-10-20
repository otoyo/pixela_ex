defmodule PixelaEx.Client do
  @moduledoc """
  HTTP Client for Pixela API.
  """

  use HTTPotion.Base

  def api_endpoint, do: "https://pixe.la/v1/"

  def process_url(url) do
    api_endpoint() <> url
  end

  def process_request_headers(headers) do
    headers
    |> Keyword.put(:"User-Agent", "pixela_ex (https://github.com/otoyo/pixela_ex)")
    |> Keyword.put(:"Content-Type", "application/json")
  end

  def process_request_body(""), do: ""
  def process_request_body(body) when is_map(body) do
    body
    |> Enum.reduce(%{}, fn {key, val}, acc ->
      acc |> Map.put(_format_key(key), _format_value(val))
    end)
    |> Poison.encode!
  end

  def process_response_body(body) do
    body |> Poison.decode!
  end

  def _format_key(key) when is_atom(key) do
    key |> Atom.to_string() |> _format_key()
  end
  def _format_key(key) do
    {head, tail} =
      key
      |> Macro.camelize
      |> String.split_at(1)

    String.downcase(head) <> tail
  end

  def _format_value(true),  do: "yes"
  def _format_value(false), do: "no"
  def _format_value(value), do: value
end
