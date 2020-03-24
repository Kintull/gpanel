defmodule GpanelWeb.Router do
  use GpanelWeb, :router

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

  scope "/", GpanelWeb do
    pipe_through :browser

    get "/", PageController, :index

    scope "/api/" do
        post "/start_server", PageController, :start_server
        post "/stop_server", PageController, :stop_server
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", GpanelWeb do
  #   pipe_through :api
  # end
end
