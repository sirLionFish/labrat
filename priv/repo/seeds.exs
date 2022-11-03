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

Labrat.Accounts.register_admin(%{
  email: "admin@compnay.com",
  password: "abc123456789",
  password_confirmation: "abc123456789"
})

Labrat.Accounts.register_user(%{
  email: "user1@company.com",
  password: "abc123456789",
  password_confirmation: "abc123456789"
})
