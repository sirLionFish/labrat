defmodule Labrat.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :date, :string
    field :description, :string
    field :name, :string
    field :price, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :price, :date, :description])
    |> validate_required([:name, :price, :date, :description])
  end

  def create_changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :price, :date, :description, :user_id])
    |> validate_required([:name, :price, :date, :description, :user_id])
  end
end
