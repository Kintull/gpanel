defmodule GPanel.Accounts do
  @moduledoc """
  This file handles commands related to an accout:
    * user creation
  """

  alias GPanel.Accounts.User
  alias GPanel.Repo

  def get_or_create_user(account_params) do
    case get_user_by_email(account_params.email) do
      %User{} = user ->
        user
      nil ->
        create_user(account_params)
    end
  end

  def create_user(account_params) do
    %User{}
    |> User.changeset(account_params)
    |> IO.inspect(label: "changeset")
    |> Repo.insert()
  end

  @spec user_changeset(User.t()) :: Ecto.Changeset.t()
  def user_changeset(user \\ %User{}) do
    User.changeset(user)
  end

  @spec get_user(integer) :: User.t() | nil
  def get_user(id) do
    Repo.get(User, id)
  end

  @spec get_user_by_email(binary) :: User.t() | nil
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end
end