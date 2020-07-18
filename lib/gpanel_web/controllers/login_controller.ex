defmodule GPanelWeb.LoginController do
  use GPanelWeb, :controller

  alias Ueberauth.Strategy.Helpers
  alias GPanel.Accounts.User
  alias GPanel.Repo

  def new(conn, _params) do
    render(conn,
      :new,
      changeset: conn,
      callback_url: Helpers.callback_url(conn)
    )
  end
end
