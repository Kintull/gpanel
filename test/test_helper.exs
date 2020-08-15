#Application.put_env(:wallaby, :base_url, GPanelWeb.Endpoint.url)
{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.start()

#{:ok, _} = Application.ensure_all_started(:wallaby)

Ecto.Adapters.SQL.Sandbox.mode(GPanel.Repo, :manual)
