defmodule GPanelWeb.UserController do
  use GPanelWeb, :controller

  alias GPanel.Schemas.User
  alias GPanel.Repo

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      nil ->
        conn
        |> put_flash(:info, "User not found")
        |> redirect(to: "/")

      user ->
        conn
        |> render("show.html", %{user: user})
    end
  end

  def show(conn, _params) do
    redirect(conn, to: "/404.html")
  end

end
