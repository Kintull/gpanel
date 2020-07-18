defmodule GPanelWeb.LoginControllerTest do
  use GPanelWeb.ConnCase
  alias GPanel.Repo
  alias GPanel.Accounts.User

  test "GET /login", %{conn: conn} do
    conn = get(conn, "/login")
    assert html_response(conn, 200) =~ "Welcome back!"
  end

  test "POST /login", %{conn: conn} do
    email = "test@gmail.com"
    params = %{
      email: email,
      password: "123123",
      password_confirmation: "123213"
    }

    conn = post(conn, "/login", params)
    %User{} = Repo.get_by(User, email: email)
    assert html_response(conn, 302)
  end
end