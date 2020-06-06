defmodule GPanelWeb.RegistrationController do
  use GPanelWeb, :controller

  alias GPanel.Schemas.User
  alias GPanel.Repo

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, changeset: changeset)
  end

  def register(conn, params) do
    IO.inspect(params, label: "create user params")

    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        redirect(conn, to: "/users/#{user.id}")
      {:error, changeset} ->
        IO.inspect(changeset, label: "Failed to create user")
        conn
        |> put_flash(:info, "User cannot be created, please contact support")
        |> redirect(to: "/")
    end
  end

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
