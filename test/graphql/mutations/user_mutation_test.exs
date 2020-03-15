defmodule Graphql.Mutations.UserMutationTest do

  use ExUnit.Case
  use HelloWeb.ConnCase
  alias HelloWeb.AbsintheHelpers


  describe "" do
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
