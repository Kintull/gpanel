defmodule Support.Factory.PterodactylUser do
  @moduledoc false

  defmacro __using__(_opts) do
    quote location: :keep do
      def pterodactyl_user_factory(attrs) do
        id = Enum.random(0..1000)
        email = "#{id}@mail.com"

        %{
          username: "username_#{id}",
          email: email,
          first_name: "First",
          last_name: "Last",
          language: "en",
          is_admin: false,
          root_admin: false
        }
        |> merge_attributes(attrs)
      end
    end
  end
end
