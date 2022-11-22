defmodule Labrat.ProductFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Labrat.Product` context.
  """

  @doc """
  Generate a stuff.
  """
  def stuff_fixture(attrs \\ %{}) do
    {:ok, stuff} =
      attrs
      |> Enum.into(%{
        items: "some items",
        service: "some service"
      })
      |> Labrat.Product.create_stuff()

    stuff
  end
end
