defmodule LabratWeb.StuffControllerTest do
  use LabratWeb.ConnCase

  import Labrat.ProductFixtures

  alias Labrat.Product.Stuff

  @create_attrs %{
    items: "some items",
    service: "some service"
  }
  @update_attrs %{
    items: "some updated items",
    service: "some updated service"
  }
  @invalid_attrs %{items: nil, service: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.stuff_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create stuff" do
    test "renders stuff when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stuff_path(conn, :create), stuff: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.stuff_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "items" => "some items",
               "service" => "some service"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stuff_path(conn, :create), stuff: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update stuff" do
    setup [:create_stuff]

    test "renders stuff when data is valid", %{conn: conn, stuff: %Stuff{id: id} = stuff} do
      conn = put(conn, Routes.stuff_path(conn, :update, stuff), stuff: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.stuff_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "items" => "some updated items",
               "service" => "some updated service"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, stuff: stuff} do
      conn = put(conn, Routes.stuff_path(conn, :update, stuff), stuff: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete stuff" do
    setup [:create_stuff]

    test "deletes chosen stuff", %{conn: conn, stuff: stuff} do
      conn = delete(conn, Routes.stuff_path(conn, :delete, stuff))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.stuff_path(conn, :show, stuff))
      end
    end
  end

  defp create_stuff(_) do
    stuff = stuff_fixture()
    %{stuff: stuff}
  end
end
