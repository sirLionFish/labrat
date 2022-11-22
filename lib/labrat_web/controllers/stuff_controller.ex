defmodule LabratWeb.StuffController do
  use LabratWeb, :controller

  alias Labrat.Product
  alias Labrat.Product.Stuff

  action_fallback LabratWeb.FallbackController

  def index(conn, _params) do
    products = Product.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"stuff" => stuff_params}) do
    with {:ok, %Stuff{} = stuff} <- Product.create_stuff(stuff_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.stuff_path(conn, :show, stuff))
      |> render("show.json", stuff: stuff)
    end
  end

  def show(conn, %{"id" => id}) do
    stuff = Product.get_stuff!(id)
    render(conn, "show.json", stuff: stuff)
  end

  def update(conn, %{"id" => id, "stuff" => stuff_params}) do
    stuff = Product.get_stuff!(id)

    with {:ok, %Stuff{} = stuff} <- Product.update_stuff(stuff, stuff_params) do
      render(conn, "show.json", stuff: stuff)
    end
  end

  def delete(conn, %{"id" => id}) do
    stuff = Product.get_stuff!(id)

    with {:ok, %Stuff{}} <- Product.delete_stuff(stuff) do
      send_resp(conn, :no_content, "")
    end
  end
end
