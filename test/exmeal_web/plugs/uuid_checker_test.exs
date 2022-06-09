defmodule Exmeal.UUIDCheckerTest do
  use ExmealWeb.ConnCase, async: true

  alias ExmealWeb.Plugs.UUIDChecker

  describe "init/1" do
    test "when init called with a scruct, return struct" do
      opts = %{}

      response = UUIDChecker.init(opts)

      assert response == opts
    end
  end

  describe "call/2" do
    test "when id format in params invalid, return an error", %{conn: conn} do
      id = "12345"
      opts = %{}

      response =
        %{conn | params: %{"id" => id}}
        |> UUIDChecker.call(opts)
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end
  end

end
