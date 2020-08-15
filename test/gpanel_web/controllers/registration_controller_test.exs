defmodule GPanelWeb.RegistrationControllerTest do
  use GPanelWeb.ConnCase
  alias GPanel.Repo
  alias GPanel.Accounts.User

  test "GET /registration", %{conn: conn} do
    conn = get(conn, "/registration")
    assert html_response(conn, 200) =~ "Get brand new server!"
  end

  test "POST /auth/identity/callback", %{conn: conn} do
    email = "test@email.com"

    conn =
      conn
      |> Plug.Conn.assign(:ueberauth_auth, valid_account_params(%{email: email}))
      |> post("/auth/identity/callback")

    assert %User{} = Repo.get_by(User, email: email)
    assert html_response(conn, 302)
  end

  defp valid_account_params(%{email: email}) do
    %Ueberauth.Auth{
      credentials: %Ueberauth.Auth.Credentials{
        other: %{
          password: "superdupersecret",
          password_confirmation: "superdupersecret"
        }
      },
      info: %Ueberauth.Auth.Info{
        email: email
      }
    }
  end
end