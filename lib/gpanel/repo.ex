defmodule Gpanel.Repo do
  use Ecto.Repo,
    otp_app: :gpanel,
    adapter: Ecto.Adapters.Postgres
end
