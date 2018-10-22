defmodule PixelaEx.Client.UserFunctions do
  @moduledoc """
  API User Functions for Pixela.
  """

  defmacro __using__(_) do
    quote do

      @doc """
      Create a new Pixela user.

      ## Examples

          iex> PixelaEx.create_user(%{username: "a-know", token: "thisissecret", agree_terms_of_service: true, not_minor: true})
          %{"message" => "Success.", "isSuccess" => true}

      """
      @spec create_user(%{required(:username) => username, required(:token) => token, required(:agree_terms_of_service) => agree_terms_of_service, required(:not_minor) => not_minor}) :: http_result
      def create_user(%{username: username, token: token, agree_terms_of_service: agree_terms_of_service, not_minor: not_minor}) do
        body = %{
          username:             username,
          token:                token,
          agreeTermsOfService:  agree_terms_of_service,
          notMinor:             not_minor
        }

        PixelaEx.Client.post "users", [body: body]
      end

      @doc """
      Updates the authentication token for the specified user.

      ## Examples

          iex> PixelaEx.update_user("a-know", "thisissecret", %{new_token: "thisissecret"})
          %{"message" => "Success.", "isSuccess" => true}

      """
      @spec update_user(username, token, %{required(:new_token) => new_token}) :: http_result
      def update_user(username, token, %{new_token: new_token}) do
        body = %{
          new_token: new_token
        }

        PixelaEx.Client.put "users/#{username}", [body: body, headers: ["X-USER-TOKEN": token]]
      end

      @doc """
      Deletes the specified registered user.

      ## Examples

          iex> PixelaEx.delete_user("a-know", "thisissecret")
          %{"message" => "Success.", "isSuccess" => true}

      """
      @spec delete_user(username, token) :: http_result
      def delete_user(username, token) do
        PixelaEx.Client.delete "users/#{username}", [headers: ["X-USER-TOKEN": token]]
      end
    end
  end
end
