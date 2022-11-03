defmodule LabratWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers
  alias Labrat.Accounts
  alias Labrat.Accounts.User
  alias LabratWeb.Router.Helpers, as: Routes
  alias Phoenix.LiveView.JS
  alias LabratWeb.UserAuth

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.game_index_path(@socket, :index)}>
        <.live_component
          module={LabratWeb.GameLive.FormComponent}
          id={@game.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.game_index_path(@socket, :index)}
          game: @game
        />
      </.modal>
  """


  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="phx-modal fade-in" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="phx-modal-content fade-in-scale"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch "✖",
            to: @return_to,
            id: "close",
            class: "phx-modal-close",
            phx_click: hide_modal()
          %>
        <% else %>
          <a id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}>✖</a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end

  def assign_defaults(session, socket) do
    LabratWeb.Endpoint.subscribe(UserAuth.pubsub_topic())
    socket = assign_new(socket, :current_user, fn ->
      find_current_user(session)
    end)

    case socket.assigns.current_user do
      %User{} ->
        socket

      _other ->
        socket
        |> put_flash(:error, "You're not logged in")
        |> redirect(to: Routes.user_session_path(socket, :new))
    end
  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
      %User{} = user <- Accounts.get_user_by_session_token(user_token), do: user
  end
end
