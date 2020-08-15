defmodule GPanel.PterodactylTest do
  use GPanel.DataCase

  import Support.Factory

  alias GPanel.Pterodactyl

  test "create pterodactyl user" do
    build(:pterodactyl_user)
    |> Pterodactyl.create_user()
  end
end