defmodule HelloWeb.UserController do
  use HelloWeb, :controller

  def getUser(conn, _params) do
    conn
    |>json(%{"message" => "success"})
  end
end
