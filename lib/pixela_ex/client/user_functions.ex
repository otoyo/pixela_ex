defmodule PixelaEx.Client.UserFunctions do
  @moduledoc false

  # API User Functions for Pixela

  @doc """

  ## Examples

      iex> PixelaEx.Client.UserFunctions.create_user("a-know", "thisissecret", true, true)
      {:post, ["users", [body: %{username: "a-know", token: "thisissecret", agreeTermsOfService: true, notMinor: true}]]}

  """
  def create_user(username, token, agree_terms_of_service, not_minor) do
    body = %{
      username: username,
      token: token,
      agreeTermsOfService: agree_terms_of_service,
      notMinor: not_minor
    }

    {:post, ["users", [body: body]]}
  end

  @doc """

  ## Examples

      iex> PixelaEx.Client.UserFunctions.update_user("a-know", "thisissecret", "thisissecret")
      {:put, ["users/a-know", [body: %{new_token: "thisissecret"}, headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  def update_user(username, token, new_token) do
    body = %{
      new_token: new_token
    }

    {:put, ["users/#{username}", [body: body, headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """

  ## Examples

      iex> PixelaEx.Client.UserFunctions.delete_user("a-know", "thisissecret")
      {:delete, ["users/a-know", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  def delete_user(username, token) do
    {:delete, ["users/#{username}", [headers: ["X-USER-TOKEN": token]]]}
  end
end
