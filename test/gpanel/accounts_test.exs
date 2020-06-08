defmodule GPanelWeb.AccountsTest do
  use GPanel.DataCase
  alias GPanel.Repo
  alias GPanel.Schemas.User
  alias GPanel.Accounts

  test "register for an account with valid information" do
    pre_count = count_of(User)
    params = valid_account_params()

    result = Accounts.register_user(params)

    assert {:ok, %User{}} = result
    assert pre_count + 1 == count_of(User)
  end


  test "register for an account with an existing email address" do
    params = valid_account_params()
    Repo.insert!(%User{email: params.info.email})

    pre_count = count_of(User)

    result = Accounts.register_user(params)

    assert {:error, %Ecto.Changeset{}} = result
    assert pre_count == count_of(User)
  end

  test "register for an account without matching password and confirmation" do
    pre_count = count_of(User)
    %{credentials: credentials} = params = valid_account_params()

    params = %{
      params
    | credentials: %{
        credentials
      | other: %{
          password: "superdupersecret",
          password_confirmation: "somethingelse"
        }
      }
    }

    result = Accounts.register_user(params)

    assert {:error, %Ecto.Changeset{}} = result
    assert pre_count == count_of(User)
  end

  defp count_of(queryable) do
    GPanel.Repo.aggregate(queryable, :count, :id)
  end

  defp valid_account_params do
    %Ueberauth.Auth{
      credentials: %Ueberauth.Auth.Credentials{
        other: %{
          password: "superdupersecret",
          password_confirmation: "superdupersecret"
        }
      },
      info: %Ueberauth.Auth.Info{
        email: "me@example.com"
      }
    }
  end
end