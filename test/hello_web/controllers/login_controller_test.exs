defmodule HelloWeb.LoginControllerTest do
  use ExUnit.Case
  use HelloWeb.ConnCase
  alias Hello.Accounts
  defp with_create_account (_tags) do
    user_attrs = %{
      username: "test",
      password: "123456"
    }
    user = Accounts.create_user(user_attrs)
    {:ok, user: user}
  end

  describe "test login" do
    setup [:with_create_account]
    test "test get user router", %{conn: conn} do

      response =
      conn
      |> get("/login")
      |> json_response(200)
      |> IO.inspect(label: "response => ", pretty: true)
      assert Map.get(response, "message" ) == "success"

    end

    test "when i input username is test and password is 123456, will login success", tags do

      user = elem(tags.user, 1)
      response =
      tags.conn
      |> post("/login", %{username: user.username, password: user.password})
      |> json_response(200)
      |> IO.inspect(label: "login response => ", pretty: true)
      assert Map.get(response, "result" ) == "ok"
      assert get_in(response, ["user", "username"] ) == "test"
      assert get_in(response, ["user", "password"] ) == "123456"

    end

    test "when i input username is jayden and password is 123456, will return record_not_found", tags do

      user = elem(tags.user, 1)
      response =
      tags.conn
      |> post("/login", %{username: "jayden", password: user.password})
      |> json_response(200)
      |> IO.inspect(label: "login response => ", pretty: true)
      assert Map.get(response, "result" ) == "error"
      assert get_in(response, ["message"] ) == "record_not_found"
    end


  end

end
