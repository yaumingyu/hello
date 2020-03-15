defmodule HelloWeb.UserControllerTest do
  use ExUnit.Case
  use HelloWeb.ConnCase
  alias HelloWeb.AbsintheHelpers
  alias Hello.Accounts


  setup do
    user_attrs = %{
      username: "test",
      password: "123456"
    }
    user = Accounts.create_user(user_attrs)
    |>IO.inspect(label: "setup response => ", pretty: true)
    {:ok, user: user}
  end

  # 测试工作日志属性


  def createTestUser (attr) do
    Accounts.create_user(attr)
  end


  describe "user_controller" do
    test "test get user router", %{conn: conn} do
      conn = get(conn, "/user/get")
      res = conn.resp_body
      assert Jason.decode(res)
      |>elem(1)
      |>Map.get("message")
      == "success"
      assert conn.status == 200
    end

    test "get user list", tag do
      query = """
        {
          users{
            username
            password
          }
        }
      """
      response =
        tag.conn
        |> post("/graphiql", AbsintheHelpers.query_skeleton(query, "getUsers"))
        |> json_response(200)
        |> IO.inspect(label: "response => ", pretty: true)
      assert get_in(response, ["data", "users"]) == [%{"password" => "123456", "username" => "test"}]
    end

    test "put user", tag do
      mutation = """
        mutation CreateUser{
          createUser(username: "jayden", password: "123456") {
            id
            username
            password
          }
        }
      """

      response =
        tag.conn
        |> post("/graphiql", AbsintheHelpers.mutation_skeleton(mutation))
        |> json_response(200)

      assert get_in(response, ["data", "createUser", "username"]) == "jayden"
      assert get_in(response, ["data", "createUser", "password"]) == "123456"
    end
  end

end
