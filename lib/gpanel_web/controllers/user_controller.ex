defmodule GPanelWeb.UserController do
  use GPanelWeb, :controller

  alias GPanel.Accounts.User
  alias GPanelWeb.Guardian

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, _params) do
    case Guardian.get_current_user(conn) do
      nil ->
        conn
        |> put_flash(:info, "User not found")
        |> redirect(to: "/")

      %User{} = user ->
        conn
        |> render("show.html", %{user: user})
    end
  end
end
