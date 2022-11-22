defmodule Labrat.Product.Stuff do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :items, :string
    field :service, :string

    timestamps()
  end

  @doc false
  def changeset(stuff, attrs) do
    stuff
    |> cast(attrs, [:items, :service])
    |> validate_required([:items, :service])
  end
end
