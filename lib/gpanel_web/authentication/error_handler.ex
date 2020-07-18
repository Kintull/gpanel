defmodule GPanelWeb.Guardian.ErrorHandler do
  use GPanelWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    IO.inspect(type)
    IO.inspect(reason)
    conn
    |> put_flash(:error, "Authentication error.")
    |> redirect(to: Routes.login_path(conn, :new))
    |> halt
  end
end