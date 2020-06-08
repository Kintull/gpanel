defmodule GPanelWeb.Router do
  use GPanelWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :guardian do
    plug GPanelWeb.Authentication.Pipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GPanelWeb do
    pipe_through [:browser, :guardian]

    get "/", PageController, :index
    get "/registration", RegistrationController, :new
    post "/auth/identity/callback", RegistrationController, :register_callback

    get "/login", LoginController, :new
    post "/login", LoginController, :login

    get "/users", UserController, :show

  end

  scope "/api/", GPanelWeb do
    pipe_through [:browser, :api]
    post "/start_server", PageController, :start_server
    post "/stop_server", PageController, :stop_server
  end

  # Other scopes may use custom stacks.
  # scope "/api", GPanelWeb do
  #   pipe_through :api
  # end
end
