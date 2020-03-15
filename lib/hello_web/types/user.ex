defmodule HelloWeb.Types.User do
  use Absinthe.Schema.Notation


  object :user do
    field :id, :id
    field :username, :string
    field :password, :string
  end


  @desc "创建 user的input对象"
  input_object :create_user_input do
    @desc "用户名"
    field(:username, non_null(:string))
    @desc "密码"
    field(:password, non_null(:string))
  end
end
