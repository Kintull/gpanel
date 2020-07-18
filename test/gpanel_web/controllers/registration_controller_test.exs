defmodule GPanelWeb.RegistrationControllerTest do
  use GPanelWeb.ConnCase
  alias GPanel.Repo
  alias GPanel.Accounts.User

  test "GET /registration", %{conn: conn} do
    conn = get(conn, "/registration")
    assert html_response(conn, 200) =~ "Get brand new server!"
  end

  test "POST /auth/identity/callback", %{conn: conn} do
    email = "test@gmail.com"
    params = %{
      email: email,
      password: "123123",
      password_confirmation: "123213"
    }

    conn =
      conn
      |> Plug.Conn.assign(:ueberauth_auth, valid_account_params())
      |> post("/auth/identity/callback", params)

    %User{} = Repo.get_by(User, email: email)
    assert html_response(conn, 302)
  end

  defp valid_account_params do
    %Ueberauth.Auth{
      credentials: %Ueberauth.Auth.Credentials{
        other: %{
          password: "superdupersecret",
          password_confirmation: "superdupersecret"
        }
      },
      info: %Ueberauth.Auth.Info{
        email: "me@example.com"
      }
    }
  end
end