defmodule GPanelWeb.Guardian.ErrorHandler do
  use GPanelWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do

    conn
    |> put_flash(:error, "Authentication error.")
    |> send_resp(401, to_string(type))
    |> redirect(to: Routes.login_path(conn, :new))
    |> halt
  end
end