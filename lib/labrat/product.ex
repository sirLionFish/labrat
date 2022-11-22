defmodule Labrat.Product do

  import Ecto.Query, warn: false
  alias Labrat.Repo

  alias Labrat.Product.Stuff

  def list_products do
    Repo.all(Stuff)
  end

  def get_stuff!(id), do: Repo.get!(Stuff, id)

  def create_stuff(attrs \\ %{}) do
    %Stuff{}
    |> Stuff.changeset(attrs)
    |> Repo.insert()
  end

  def update_stuff(%Stuff{} = stuff, attrs) do
    stuff
    |> Stuff.changeset(attrs)
    |> Repo.update()
  end

  def delete_stuff(%Stuff{} = stuff) do
    Repo.delete(stuff)
  end

  def change_stuff(%Stuff{} = stuff, attrs \\ %{}) do
    Stuff.changeset(stuff, attrs)
  end
end
