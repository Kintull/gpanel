  defmodule GPanelWeb.Authentication do
  @moduledoc """
  Implementation module for Guardian and functions for authentication.
  """

  use Guardian, otp_app: :gpanel
  alias GPanel.Accounts

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  def log_in(conn, user) do
    require IEx; IEx.pry

    __MODULE__.Plug.sign_in(conn, user)
  end
end