defmodule GPanel.Repo.Migrations.AddUserConstraint do
  use Ecto.Migration

  def change do
    create unique_index("users", [:email], comment: "Index email")
  end
end
