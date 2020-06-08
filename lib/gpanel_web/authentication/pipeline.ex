defmodule GPanelWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :gpanel,
      error_handler: GPanelWeb.Authentication.ErrorHandler,
      module: GPanelWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end