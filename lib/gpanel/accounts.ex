defmodule GPanel.Accounts do
  @moduledoc """
  This file handles commands related to an accout:
    * user creation
  """

  alias GPanel.Schemas.User
  alias GPanel.Repo

  def register_user(%Ueberauth.Auth{} = params) do
    %User{}
    |> User.changeset(extract_user_params(params))
    |> Repo.insert()
  end

  def update_user(user \\ %User{}) do
    User.changeset(user, %{})
  end

  def get_user(user \\ %User{}) do
    Repo.get(User, user.id)
  end

  defp extract_user_params(%{credentials: %{other: other}, info: info}) do
    info
    |> Map.from_struct()
    |> Map.merge(other)
  end
end