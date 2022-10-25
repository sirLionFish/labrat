defmodule LabratWeb.UserDashboardLiveTest do

  use LabratWeb.ConnCase
  import Phoenix.LiveViewTest
  import Labrat.AccountsFixtures

  test “disconnected and connected render without authentication should redirect to login page”,
       %{conn: conn} do

    # If we don’t previously log in we will be redirected to the login page
    assert {:error, {:redirect, %{to: “/users/log_in”}}} = live(conn, “/user_dashboard”)
  end

  test “disconnected and connected render authenticated with user permissions should redirect to index page”,
       %{
         conn: conn
       } do

    conn = conn |> log_in_user(user_fixture())
    {:ok, user_dashboard, disconnected_html} = live(conn, “/user_dashboard”)
    assert disconnected_html =~ “Welcome to the user dashboard!”
    assert render(user_dashboard) =~ “Welcome to the user dashboard!”
  end

  test “disconnected and connected render authenticated with admin permissions should redirect to index page”,
       %{
         conn: conn
       } do

    conn = conn |> log_in_user(admin_fixture())
    {:ok, user_dashboard, disconnected_html} = live(conn, “/user_dashboard”)
    assert disconnected_html =~ “Welcome to the user dashboard!”
    assert render(user_dashboard) =~ “Welcome to the user dashboard!”
  end
end
