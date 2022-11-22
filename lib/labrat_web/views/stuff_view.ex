defmodule LabratWeb.StuffView do
  use LabratWeb, :view
  alias LabratWeb.StuffView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, StuffView, "stuff.json")}
  end

  def render("show.json", %{stuff: stuff}) do
    %{data: render_one(stuff, StuffView, "stuff.json")}
  end

  def render("stuff.json", %{stuff: stuff}) do
    %{
      id: stuff.id,
      items: stuff.items,
      service: stuff.service
    }
  end
end
