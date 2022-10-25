defmodule Labrat.PropertiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Labrat.Properties` context.
  """

  @doc """
  Generate a property.
  """
  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: "120.5"
      })
      |> Labrat.Properties.create_property()

    property
  end
end
