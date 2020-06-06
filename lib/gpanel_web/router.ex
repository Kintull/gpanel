defmodule GPanelWeb.Router do
  use GPanelWeb, :router

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

  scope "/", GPanelWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :register

    get "/login", LoginController, :new
    post "/login", RegistrationController, :login

#    resources "/users", UserController, only: [:show, :create]

    scope "/api/" do
        post "/start_server", PageController, :start_server
        post "/stop_server", PageController, :stop_server
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", GPanelWeb do
  #   pipe_through :api
  # end
end
