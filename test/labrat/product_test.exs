defmodule Labrat.ProductTest do
  use Labrat.DataCase

  alias Labrat.Product

  describe "products" do
    alias Labrat.Product.Stuff

    import Labrat.ProductFixtures

    @invalid_attrs %{items: nil, service: nil}

    test "list_products/0 returns all products" do
      stuff = stuff_fixture()
      assert Product.list_products() == [stuff]
    end

    test "get_stuff!/1 returns the stuff with given id" do
      stuff = stuff_fixture()
      assert Product.get_stuff!(stuff.id) == stuff
    end

    test "create_stuff/1 with valid data creates a stuff" do
      valid_attrs = %{items: "some items", service: "some service"}

      assert {:ok, %Stuff{} = stuff} = Product.create_stuff(valid_attrs)
      assert stuff.items == "some items"
      assert stuff.service == "some service"
    end

    test "create_stuff/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Product.create_stuff(@invalid_attrs)
    end

    test "update_stuff/2 with valid data updates the stuff" do
      stuff = stuff_fixture()
      update_attrs = %{items: "some updated items", service: "some updated service"}

      assert {:ok, %Stuff{} = stuff} = Product.update_stuff(stuff, update_attrs)
      assert stuff.items == "some updated items"
      assert stuff.service == "some updated service"
    end

    test "update_stuff/2 with invalid data returns error changeset" do
      stuff = stuff_fixture()
      assert {:error, %Ecto.Changeset{}} = Product.update_stuff(stuff, @invalid_attrs)
      assert stuff == Product.get_stuff!(stuff.id)
    end

    test "delete_stuff/1 deletes the stuff" do
      stuff = stuff_fixture()
      assert {:ok, %Stuff{}} = Product.delete_stuff(stuff)
      assert_raise Ecto.NoResultsError, fn -> Product.get_stuff!(stuff.id) end
    end

    test "change_stuff/1 returns a stuff changeset" do
      stuff = stuff_fixture()
      assert %Ecto.Changeset{} = Product.change_stuff(stuff)
    end
  end
end
