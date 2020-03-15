defmodule HelloWeb.Resolvers.User do
  alias Hello.Accounts
  def list_users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def create_user(_parent, args, _resolution) do
    Accounts.create_user(args)
  end

end
