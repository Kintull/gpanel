defmodule Support.Factory.User do
  @moduledoc false

  defmacro __using__(_opts) do
    quote location: :keep do
      alias Comeonin.Bcrypt

      def user_factory(attrs) do
        id = Enum.random(0..1000)
        email = "#{id}@mail.com"
        password = attrs.password || to_string(id)
        password_hash = Bcrypt.hashpwsalt(password)

        %GPanel.Accounts.User{
          id: id,
          email: email,
          password_hash: password_hash
        }
        |> merge_attributes(attrs)
      end
    end
  end
end
