defmodule PixelaEx.Client.UserFunctions do
  @moduledoc """
  API User Functions for Pixela.
  """

  @doc """
  Create a new Pixela user.

  ## Examples

      iex> PixelaEx.Client.UserFunctions.create_user("a-know", "thisissecret", true, true)
      {:post, ["users", [body: %{username: "a-know", token: "thisissecret", agreeTermsOfService: true, notMinor: true}]]}

  """
  @spec create_user(PixelaEx.username, PixelaEx.token, PixelaEx.agree_terms_of_service, PixelaEx.not_minor) :: PixelaEx.http_result
  def create_user(username, token, agree_terms_of_service, not_minor) do
    body = %{
      username:             username,
      token:                token,
      agreeTermsOfService:  agree_terms_of_service,
      notMinor:             not_minor
    }

    {:post, ["users", [body: body]]}
  end

  @doc """
  Updates the authentication token for the specified user.

  ## Examples

      iex> PixelaEx.Client.UserFunctions.update_user("a-know", "thisissecret", %{new_token: "thisissecret"})
      {:put, ["users/a-know", [body: %{new_token: "thisissecret"}, headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec update_user(PixelaEx.username, PixelaEx.token, %{required(:new_token) => PixelaEx.new_token}) :: PixelaEx.http_result
  def update_user(username, token, %{new_token: new_token}) do
    body = %{
      new_token: new_token
    }

    {:put, ["users/#{username}", [body: body, headers: ["X-USER-TOKEN": token]]]}
  end

  @doc """
  Deletes the specified registered user.

  ## Examples

      iex> PixelaEx.Client.UserFunctions.delete_user("a-know", "thisissecret")
      {:delete, ["users/a-know", [headers: ["X-USER-TOKEN": "thisissecret"]]]}

  """
  @spec delete_user(PixelaEx.username, PixelaEx.token) :: PixelaEx.http_result
  def delete_user(username, token) do
    {:delete, ["users/#{username}", [headers: ["X-USER-TOKEN": token]]]}
  end
end
