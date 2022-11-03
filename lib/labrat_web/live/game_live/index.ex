defmodule LabratWeb.GameLive.Index do
  use LabratWeb, :live_view

  alias Labrat.Games
  alias Labrat.Games.Game
  alias LabratWeb.Roles

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, assign(socket, :games, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    current_user = socket.assigns.current_user
    live_action = socket.assigns.live_action
    game = game_from_params(params)

    if Roles.can?(current_user, game, live_action) do
      {:noreply, apply_action(socket, live_action, params)}
    else
      {:noreply,
      socket
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: "/")}
    end
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Game")
    |> assign(:game, Games.get_game!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Game")
    |> assign(:game, %Game{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Games")
    |> assign(:game, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    current_user = socket.assigns.current_user
    game = Games.get_game!(id)

    if Roles.can?(current_user, game, :delete) do
      game = Games.get_game!(id)
      {:ok, _} = Games.delete_game(game)
      {:noreply, assign(socket, :games, list_games())}
    else
      {:noreply,
       socket
       |> put_flash(:error, "Unauthorised")
       |> redirect(to: "/")}
    end
  end

  defp list_games do
    Games.list_games()
  end

  defp game_from_params(params)
  defp game_from_params(%{"id" => id}), do: Games.get_game!(id)
  defp game_from_params(_params), do: %Game{}
end
