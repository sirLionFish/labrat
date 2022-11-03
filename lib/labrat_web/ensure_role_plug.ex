defmodule LabratWeb.EnsureRolePlug do
  import Plug.Conn
  alias Labrat.Accounts.User
  alias Labrat.Accounts
  alias Phoenix.Controller
  # alias Plug.Conn

  def init(config), do: config

  def call(conn, permissions) do
    user_token = get_session(conn, :user_token)

    (user_token && Accounts.get_user_by_session_token(user_token))
    |> has_permissions?(permissions)
    |> maybe_halt(conn)
  end

  defp has_permissions?(%User{} = user, permissions) when is_list(permissions),
    do: Enum.any?(permissions, &has_permissions?(user, &1))

  defp has_permissions?(%User{permissions: permissions}, permissions), do: true
  defp has_permissions?(_user, _permissions), do: false

  defp maybe_halt(true, conn), do: conn
  defp maybe_halt(_any, conn) do
    conn
    |> Controller.put_flash(:error, "Unauthorised")
    |> Controller.redirect(to: signed_in_path(conn))
    |> halt()
  end

  defp signed_in_path(_conn), do: "/"
end
