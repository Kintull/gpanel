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
    plug GPanelWeb.Guardian.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GPanelWeb do
    pipe_through [:browser, :guardian]

    get "/", PageController, :index

    get "/login", LoginController, :new
    get "/registration", RegistrationController, :new

    post "/auth/identity/callback", AuthenticationController, :identity_callback

    scope "/users" do
      pipe_through :ensure_auth
      resources "/users", UserController, only: [:show], singleton: true
    end

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
