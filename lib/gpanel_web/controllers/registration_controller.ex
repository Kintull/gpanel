defmodule GPanelWeb.RegistrationController do
  use GPanelWeb, :controller

  alias GPanel.Schemas.User
  alias GPanel.Repo
  alias GPanel.Accounts
  alias GPanelWeb.Authentication

  plug Ueberauth

  def new(conn, _params) do
#    changeset = User.changeset(%User{})
    render(conn, :new,
      changeset: Accounts.update_user(),
      action: Routes.registration_path(conn, :register_callback)
    )
  end

  def register_callback(%{assigns: %{ueberauth_auth: auth_params}} = conn, _params) do
    case Accounts.register_user(auth_params) do
      {:ok, user} ->
        conn
        |> Authentication.log_in(user)
        |> redirect(to: Routes.user_path(conn, :show))

      {:error, changeset} ->
        render(conn, :new, changeset: changeset,
          action: Routes.registration_path(conn, :register_callback))
    end
  end

  def register_callback(conn, _params) do
      IO.inspect("register_callback2")
      IO.inspect(conn, limit: :infinity)
      render(conn, changeset: conn, action: "/registration")
#    changeset = User.changeset(%User{}, params)
#
#    case Repo.insert(changeset) do
#      {:ok, user} ->
#        redirect(conn, to: "/users/#{user.id}")
#      {:error, changeset} ->
#        IO.inspect(changeset, label: "Failed to create user")
#        conn
#        |> put_flash(:info, "User cannot be created, please contact support")
#        |> redirect(to: "/")
#    end
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
