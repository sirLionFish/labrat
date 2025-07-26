defmodule Labrat.Repo do
  use Ecto.Repo,
    otp_app: :labrat,
    adapter: Ecto.Adapters.Postgres
end
