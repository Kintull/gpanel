defmodule GPanelWeb.RegistrationController do
  use GPanelWeb, :controller

  alias GPanel.Accounts
  alias Ueberauth.Strategy.Helpers

  plug Ueberauth

  def new(conn, _params) do
    render(conn,
      :new,
      changeset: Accounts.user_changeset(),
      callback_url: Helpers.callback_url(conn)
    )
  end
end
