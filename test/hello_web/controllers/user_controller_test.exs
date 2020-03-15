defmodule HelloWeb.UserControllerTest do
  use ExUnit.Case
  use HelloWeb.ConnCase
  alias HelloWeb.AbsintheHelpers
  alias Hello.Accounts


  # 测试工作日志属性


  defp with_create_test_user (_tags) do
    user_attrs = %{
      username: "test",
      password: "123456"
    }
    user = Accounts.create_user(user_attrs)
    {:ok, user: user}
  end


  describe "user_controller" do
    setup [:with_create_test_user]

    test "test get user router", %{conn: conn} do

      response =
      conn
      |> get("/user/get")
      |> json_response(200)
      |> IO.inspect(label: "response => ", pretty: true)
      assert Map.get(response, "message" ) == "success"

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
        mutation CreateUser($input: CreateUserInput!){
          createUser(input: $input) {
            id
            username
            password
          }
        }
      """

      create_user_input = %{
        "input" => %{
          "username" => "jayden",
          "password" => "123456"
        }
      }

      response =
        tag.conn
        |> post("/graphiql", AbsintheHelpers.mutation_skeleton(mutation, create_user_input))
        |> json_response(200)
        |> IO.inspect(label: "response => ", pretty: true)

      assert get_in(response, ["data", "createUser", "username"]) == "jayden"
      assert get_in(response, ["data", "createUser", "password"]) == "123456"
    end
  end

end
