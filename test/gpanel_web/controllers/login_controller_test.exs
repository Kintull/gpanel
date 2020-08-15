defmodule GPanelWeb.LoginControllerTest do
  use GPanelWeb.ConnCase

  test "GET /login", %{conn: conn} do
    conn = get(conn, "/login")
    assert html_response(conn, 200) =~ "Welcome back!"
  end
end