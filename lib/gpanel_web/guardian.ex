  defmodule GPanelWeb.Guardian do
  @moduledoc """
  Implementation module for Guardian and functions for authentication.
  """

  use Guardian, otp_app: :gpanel
  alias GPanel.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.email)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  def log_in(conn, user) do
    __MODULE__.Plug.sign_in(conn, user)
  end

  def user_authorized?(conn) do
    __MODULE__.Plug.authenticated?(conn)
  end
end