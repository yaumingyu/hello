defmodule Graphql.Querys.UserQueryTest do

  use ExUnit.Case
  use HelloWeb.ConnCase
  alias HelloWeb.AbsintheHelpers
  alias Hello.Accounts

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

  end
end
