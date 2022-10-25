defmodule Labrat.Properties.Property do
  use Ecto.Schema
  import Ecto.Changeset

  schema "properties" do
    field :description, :string
    field :name, :string
    field :price, :decimal
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :price, :description])
    |> validate_required([:name, :price, :description])
  end

   def create_changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :price, :description, :user_id])
    |> validate_required([:name, :price, :description, :user_id])
  end
end
