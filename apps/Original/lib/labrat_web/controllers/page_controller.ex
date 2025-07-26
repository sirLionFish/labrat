defmodule LabratWeb.PageController do
  use LabratWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
