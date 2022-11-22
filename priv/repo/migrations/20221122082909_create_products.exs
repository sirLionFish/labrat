defmodule Labrat.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :items, :string
      add :service, :string

      timestamps()
    end
  end
end
