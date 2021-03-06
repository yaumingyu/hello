defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/login", HelloWeb do
    pipe_through :api

    get "/", LoginController, :getUser
    post "/", LoginController, :login

  end


  scope "/graphiql" do
    pipe_through [:api]

    forward "/", Absinthe.Plug.GraphiQL, schema: HelloWeb.Schema
  end


  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
