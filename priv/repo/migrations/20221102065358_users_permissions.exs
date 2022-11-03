defmodule Labrat.Repo.Migrations.UsersPermissions do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :permissions, :string
    end
  end
end
