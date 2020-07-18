defmodule GPanelWeb.AuthenticationController do
  @moduledoc false
  use GPanelWeb, :controller
  alias GPanel.Accounts
  alias Ueberauth.Strategy.Helpers
  alias GPanelWeb.RegistrationView

  plug Ueberauth

  def identity_callback(%{assigns: %{ueberauth_auth: auth_params}} = conn, _params) do
    require IEx; IEx.pry

    email = auth_params.info.email
    password = auth_params.credentials.other.password

#    cond do
#      user && validate_password(password, user.password_hash) ->
#        conn
#        |> Guardian.log_in(user)
#        |> redirect(to: Routes.user_path(conn, :show))
#
#      user ->
#        conn
#        |> Guardian.log_in(user)
#        |> redirect(to: Routes.user_path(conn, :show))
#
#      true ->
#        dummy_validate_password()
#        render(conn, :new, changeset: changeset,
#          action: Helpers.callback_url(conn))
#    end

    account_params = build_create_account_params(auth_params)

    case Accounts.get_or_create_user(account_params) do
      {:ok, user} ->
        conn
        |> Guardian.log_in(user)
        |> redirect(to: Routes.user_path(conn, :show))

      {:error, changeset} ->
      conn
      |> put_view(RegistrationView)
      |> render(
           :new,
           changeset: changeset,
           callback_url: Helpers.callback_url(conn)
        )
    end
  end

  defp build_create_account_params(%Ueberauth.Auth{} = auth_params) do
    email = auth_params.info.email
    password = auth_params.credentials.other.password
    Map.new()
    |> Map.merge(Map.from_struct(auth_params.info))
    |> Map.merge(auth_params.credentials.other)
  end
end