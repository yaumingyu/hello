defmodule HelloWeb.LoginController do
  use HelloWeb, :controller
  alias Hello.Accounts

  def getUser(conn, _params) do
    conn
    |>json(%{"message" => "success"})
  end

  def login(conn, params) do
    user = Accounts.find_one(params)
    res =  formatUserRes(user)
    conn
    |>json(res)
  end

  def formatUserRes ({:ok, value}) do
    %{result: :ok, user: value}
  end

  def formatUserRes ({:error, value}) do
    %{result: :error, message: value}
  end


end
