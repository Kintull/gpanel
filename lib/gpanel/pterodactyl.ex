defmodule GPanel.Pterodactyl do
  @moduledoc false

  def create_user(params \\ %{}) do
    params = %{
      username: "happy_otter_1",
      email: params.email,
      first_name: "First",
      last_name: "Last",
      language: "en",
      is_admin: true
    }
    |> Map.merge(params)

    resp = Elidactyl.Users.create_user(params)
    IO.inspect(resp)
  end


end