defmodule GPanelWeb.PageControllerTest do
  use GPanelWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Choose a game"
  end
end
