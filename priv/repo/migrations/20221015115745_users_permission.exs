defmodule Labrat.Repo.Migrations.UsersPermission do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :permissions, :string
    end
  end
end
