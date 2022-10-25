# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Labrat.Repo.insert!(%Labrat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Labrat.Accounts.register_admin(%{
#   email: "admin@company.com",
#   password: "123456789abc",
#   password_confirmation: "123456789abc"
# })

# Labrat.Accounts.register_user(%{
#   email: "user1@company.com",
#   password: "123456789abc",
#   password_confirmation: "123456789abc"
# })

# Labrat.Accounts.register_user(%{
#   email: "user2@company.com",
#   password: "123456789abc",
#   password_confirmation: "123456789abc"
# })

{:ok, admin} =
  Labrat.Accounts.register_admin(%{
    email: "admin@company.com",
    password: "123456789abc",
    password_confirmation: "123456789abc"
  })

{:ok, user_1} =
  Labrat.Accounts.register_user(%{
    email: "user1@company.com",
    password: "123456789abc",
    password_confirmation: "123456789abc"
  })

{:ok, user_2} =
  Labrat.Accounts.register_user(%{
    email: "user2@company.com",
    password: "123456789abc",
    password_confirmation: "123456789abc"
  })

# Enum.each(1..10, fn I ->
#   %{
#     name: "Property #{i} - User 1",
#     price: :rand.uniform(5) * 100_000,
#     description: "Property that belongs to user 1",
#     user_id: user_1.id
#   }
#   |> Labrat.Properties.create_property()

#   %{
#     name: "Property #{i} - User 2",
#     price: :rand.uniform(5) * 100_000,
#     description: "Property that belongs to user 2",
#     user_id: user_2.id
#   }
#   |> Labrat.Properties.create_property()

#   %{
#     name: "Property #{i} - Admin",
#     price: :rand.uniform(5) * 100_000,
#     description: "Property that belongs to admin",
#     user_id: admin.id
#   }
#   |> Labrat.Properties.create_property()

#   end)
