defmodule Support.Factory do
  @moduledoc """
  Build test-setup via ExMachina:
  https://github.com/thoughtbot/ex_machina

  *Conventions:*
  Use `build` to get a struct, use `insert` to get a struct that is also persistent in the database.
  As a rule of thumb: unit-tests *shouldn't* need persisted data, just the struct will suffice in most cases.

  *Create a struct with children via:*
  ```
  build(:application)
  |> with_model()
  ```

  This will build an application, and pass that application to `with_model`, which will then build the model
  which is linked to the page.

  E.g.
  ```
  build(:application)
  |> with_model()
  |> with_model_property()
  ```
  would keep passing the application-struct, but the model-property needs to receive the model to be able to link
  themselves to the model.

  ```
  build(:page)
  |> with_model(properties: [
    build_model_property()
  ])
  ```
  works as required.

  See the file '<new filename here>' for elaborate examples
  on how to build complex structures.
  """

  use ExMachina.Ecto, repo: GPanel.Repo

  use Support.Factory.User
  use Support.Factory.PterodactylUser
end
