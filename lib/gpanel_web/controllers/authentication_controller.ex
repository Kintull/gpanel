defmodule GPanelWeb.AuthenticationController do
  @moduledoc false
  alias Ueberauth.Strategy.Helpers
  alias GPanel.Accounts
  alias GPanelWeb.Guardian
  alias GPanelWeb.RegistrationView

  use GPanelWeb, :controller
  plug Ueberauth

  require Logger

  def identity_callback(%{assigns: %{ueberauth_auth: auth_params}} = conn, _params) do
    account_params = build_create_account_params(auth_params)

    case Accounts.get_or_create_user(account_params) do
      {:ok, user} ->
        conn
        |> Guardian.log_in(user)
        |> redirect(to: Routes.user_path(conn, :show))

      {:error, changeset} ->
        Logger.error("Failed to get or create user #{inspect changeset}")
        conn
        |> put_flash(:error, "Failed to get or create user")
        |> redirect(to: "/")
    end
  end

  defp build_create_account_params(%Ueberauth.Auth{} = auth_params) do
    Map.new()
    |> Map.merge(Map.from_struct(auth_params.info))
    |> Map.merge(auth_params.credentials.other)
  end
end