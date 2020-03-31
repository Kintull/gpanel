defmodule GPanel.Schemas.User do
  use Ecto.Schema
  alias Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def create_user_changeset(user, params \\ %{}) do
    user
    |> Changeset.cast(params, [:email, :password])
    |> Changeset.validate_required([:email, :password])
    |> Changeset.validate_length(:password, min: 6, max: 100)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %{valid?: true, changes: %{password: password}} ->
        Changeset.put_change(changeset, :password_hash, Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end