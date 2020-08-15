defmodule GPanelWeb.AccountsTest do
  use GPanel.DataCase

  import Support.Factory

  alias GPanel.Repo
  alias GPanel.Accounts.User
  alias GPanel.Accounts

  test "create new user with valid params" do
    pre_count = count_of(User)
    params = valid_account_params()

    result = Accounts.get_or_create_user(params)

    assert {:ok, %User{}} = result
    assert pre_count + 1 == count_of(User)
  end


  test "get an account with an existing email address" do
    params = valid_account_params()

    build(:user, params)
    |> Repo.insert!()

    pre_count = count_of(User)

    result = Accounts.get_or_create_user(params)

    assert {:ok, %User{}} = result
    assert pre_count == count_of(User)
  end

  test "fail to create a user without matching password and confirmation" do
    pre_count = count_of(User)
    params = password_dont_match_params()
    result = Accounts.get_or_create_user(params)

    assert {:error, %Ecto.Changeset{}} = result
    assert pre_count == count_of(User)
  end

  test "fail to create a user with bad email" do
    pre_count = count_of(User)
    params = bad_email_params()
    result = Accounts.get_or_create_user(params)

    assert {:error, %Ecto.Changeset{}} = result
    assert pre_count == count_of(User)
  end

  defp count_of(queryable) do
    GPanel.Repo.aggregate(queryable, :count, :id)
  end

  defp valid_account_params do
    %{
      password: "12345678",
      password_confirmation: "12345678",
      email: "me@example.com"
    }
  end

  defp password_dont_match_params do
      %{
        password: "12345678",
        password_confirmation: "87654321",
        email: "me@example.com"
      }
  end

  defp bad_email_params do
    %{
      password: "12345678",
      password_confirmation: "87654321",
      email: "example"
    }
  end
end