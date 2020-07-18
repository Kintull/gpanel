defmodule GPanelWeb.Guardian.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :gpanel,
      error_handler: GPanelWeb.Guardian.ErrorHandler,
      module: GPanelWeb.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end