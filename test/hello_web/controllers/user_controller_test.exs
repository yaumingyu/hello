defmodule HelloWeb.UserControllerTest do
  use ExUnit.Case
  use HelloWeb.ConnCase

  describe "user_controller" do

    test "test get user router", %{conn: conn} do

      response =
      conn
      |> get("/user/get")
      |> json_response(200)
      |> IO.inspect(label: "response => ", pretty: true)
      assert Map.get(response, "message" ) == "success"

    end

  end

end
