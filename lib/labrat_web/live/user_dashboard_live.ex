defmodule LabratWeb.UserDashboardLive do

  use LabratWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class='phx-hero'>
      <h1>Welcome to the user dashboard!</h1>
    </section>
    """
  end
end
