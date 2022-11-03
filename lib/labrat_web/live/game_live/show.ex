defmodule LabratWeb.GameLive.Show do
  use LabratWeb, :live_view

  alias Labrat.Games
  alias LabratWeb.Roles

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    current_user = socket.assigns.current_user
    live_action = socket.assigns.live_action
    game = Games.get_game!(id)

    if Roles.can?(current_user, game, live_action) do
      {:noreply,
        socket
        |> assign(:page_title, page_title(live_action))
        |> assign(:game, game)}
    else
      {:noreply,
        socket
        |> put_flash(:error, "Unauthorized")
        |> redirect(to: "/")}
    end
  end

  defp page_title(:show), do: "Show Game"
  defp page_title(:edit), do: "Edit Game"
end
