defmodule GPanelWeb.UserControllerTest do
  use GPanelWeb.ConnCase
  alias GPanel.Repo
  alias GPanel.Schemas.User

  test "POST /users", %{conn: conn} do
    password = "123123"
    email = "test@mail.com"
    conn = post(conn, "/users", %{email: email, password: password})

    assert [user] = Repo.all(User)
    assert user.email == email
    assert user.password_hash == Comeonin.Bcrypt.hashpwsalt(password)

    assert html_response(conn, 302) =~ "redirected"
  end
end