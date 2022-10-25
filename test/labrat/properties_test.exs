defmodule Labrat.PropertiesTest do
  use Labrat.DataCase

  alias Labrat.Properties

  describe "properties" do
    alias Labrat.Properties.Property

    import Labrat.PropertiesFixtures

    @invalid_attrs %{description: nil, name: nil, price: nil}

    test "list_properties/0 returns all properties" do
      property = property_fixture()
      assert Properties.list_properties() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert Properties.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      valid_attrs = %{description: "some description", name: "some name", price: "120.5"}

      assert {:ok, %Property{} = property} = Properties.create_property(valid_attrs)
      assert property.description == "some description"
      assert property.name == "some name"
      assert property.price == Decimal.new("120.5")
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Properties.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", price: "456.7"}

      assert {:ok, %Property{} = property} = Properties.update_property(property, update_attrs)
      assert property.description == "some updated description"
      assert property.name == "some updated name"
      assert property.price == Decimal.new("456.7")
    end

    test "update_property/2 with invalid data returns error changeset" do
      property = property_fixture()
      assert {:error, %Ecto.Changeset{}} = Properties.update_property(property, @invalid_attrs)
      assert property == Properties.get_property!(property.id)
    end

    test "delete_property/1 deletes the property" do
      property = property_fixture()
      assert {:ok, %Property{}} = Properties.delete_property(property)
      assert_raise Ecto.NoResultsError, fn -> Properties.get_property!(property.id) end
    end

    test "change_property/1 returns a property changeset" do
      property = property_fixture()
      assert %Ecto.Changeset{} = Properties.change_property(property)
    end
  end
end
