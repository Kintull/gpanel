defmodule GPanel.Accounts.User do
  use Ecto.Schema
  alias Ecto.Changeset
  alias Comeonin.Bcrypt

  @required [:email, :password, :password_confirmation]
  @optional []

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> Changeset.cast(params, @required, @optional)
    |> validate_password_confirmation()
    |> Changeset.validate_length(:password, min: 8, max: 100)
    |> Changeset.validate_required(@required)
    |> Changeset.unique_constraint([:email])
    |> hash_password()
  end

  defp validate_password_confirmation(changeset) do
    password = Map.get(changeset.changes, :password, nil)
    password_confirmation = Map.get(changeset.changes, :password_confirmation, nil)

    case password  do
      ^password_confirmation -> changeset
      _ -> Changeset.add_error(changeset, :password_confirmation, "Passwords do not match")
    end
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