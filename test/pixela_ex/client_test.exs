defmodule PixelaEx.ClientTest do
  use ExUnit.Case

  test "process_request_body" do
    assert PixelaEx.Client.process_request_body("") == ""
    assert PixelaEx.Client.process_request_body(%{hogeFuga: true}) == Poison.encode!(%{"hogeFuga" => "yes"})
  end

  test "_format_key" do
    assert PixelaEx.Client._format_key(:hogeFuga) == "hogeFuga"
    assert PixelaEx.Client._format_key("hogeFuga") == "hogeFuga"
  end

  test "_format_value" do
    assert PixelaEx.Client._format_value(true) == "yes"
    assert PixelaEx.Client._format_value(false) == "no"
    assert PixelaEx.Client._format_value(1) == 1
  end
end
