defmodule HelloWeb.Schema do
  use Absinthe.Schema
  import_types HelloWeb.Schemas.User

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
      arg :username, non_null(:string)
      arg :password, non_null(:string)
      resolve &Resolvers.User.create_user/3
    end

  end

end
