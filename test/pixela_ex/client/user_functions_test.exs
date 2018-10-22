defmodule PixelaEx.Client.UserFunctionsTest do
  use ExUnit.Case

  import Mock

  test_with_mock "create_user", PixelaEx.Client,
    [post: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.create_user(%{username: "a-know", token: "thisissecret", agree_terms_of_service: true, not_minor: true})
    assert called PixelaEx.Client.post "users", [body: %{username: "a-know", token: "thisissecret", agreeTermsOfService: true, notMinor: true}]
  end

  test_with_mock "update_user", PixelaEx.Client,
    [put: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.update_user("a-know", "thisissecret", %{new_token: "thisissecret"})
    assert called PixelaEx.Client.put "users/a-know", [body: %{new_token: "thisissecret"}, headers: ["X-USER-TOKEN": "thisissecret"]]
  end

  test_with_mock "delete_user", PixelaEx.Client,
    [delete: fn(_url, _headers) ->
      %HTTPotion.Response{status_code: 200,
                          body: %{"message" => "Success.", "isSuccess" => true}} end] do
    PixelaEx.delete_user("a-know", "thisissecret")
    assert called PixelaEx.Client.delete "users/a-know", [headers: ["X-USER-TOKEN": "thisissecret"]]
  end
end
