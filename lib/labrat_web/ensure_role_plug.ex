defmodule LabratWeb.EnsureRolePlug do

  @moduledoc """
  This plug ensures that a user has a particular permissions before accessing a given route.

  ## Example
  Let's suppose we have three permissionss: :admin, :manager and :user.
  If you want a user to have at least manager permissions, so admins and managers are authorised to access a given route

  plug LabratWeb.EnsurepermissionsPlug, [:admin, :manager]

  If you want to give access only to an admin:

  plug LabratWeb.EnsurepermissionsPlug, :admin
  """

  import Plug.Conn
  alias Labrat.Accounts
  alias Labrat.Accounts.User
  alias Phoenix.Controller
  alias Plug.Conn

  @doc false
  @spec init(any()) :: any()
  def init(config), do: config

  @doc false
  @spec call(Conn.t(), atom() | [atom()]) :: Conn.t()
  def call(conn, permissionss) do
    user_token = get_session(conn, :user_token)

    (user_token &&
       Accounts.get_user_by_session_token(user_token))
    |> has_permissions?(permissionss)
    |> maybe_halt(conn)
  end

  defp has_permissions?(%User{} = user, permissionss) when is_list(permissionss),
    do: Enum.any?(permissionss, &has_permissions?(user, &1))

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
