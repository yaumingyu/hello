defmodule HelloWeb.Schema do
  use Absinthe.Schema
  import_types HelloWeb.Types.User

  alias HelloWeb.Resolvers
  query do

    @desc "Get all user"
    field :users, list_of(:user) do
      resolve &Resolvers.User.list_users/3
    end

  end


  mutation do

    @desc "Create a user"
    field :create_user, type: :user do
      arg(:input, non_null(:create_user_input))
      resolve &Resolvers.User.create_user/3
    end

  end

end
