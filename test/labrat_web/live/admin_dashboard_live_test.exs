defmodule LabratWeb.AdminDashboardLiveTest do

  use LabratWeb.ConnCase
  import Phoenix.LiveViewTest
  import Labrat.AccountsFixtures

  test “disconnected and connected render without authentication should redirect to login page”,
       %{conn: conn} do

    # If we don’t previously log in we will be redirected to the login page
    assert {:error, {:redirect, %{to: “/users/log_in”}}} = live(conn, “/admin_dashboard”)
  end

  test “disconnected and connected render authenticated with user permissions should redirect to index page”,
       %{
         conn: conn
       } do

    conn = conn |> log_in_user(user_fixture())
    assert {:error, {:redirect, %{to: “/“}}} = live(conn, “/admin_dashboard”)
  end

  test “disconnected and connected render authenticated with admin permissions should redirect to index page”,
       %{
         conn: conn
       } do

    conn = conn |> log_in_user(admin_fixture())
    {:ok, admin_dashboard, disconnected_html} = live(conn, “/admin_dashboard”)
    assert disconnected_html =~ “Welcome to the admin dashboard!”
    assert render(admin_dashboard) =~ “Welcome to the admin dashboard!”
  end
end
