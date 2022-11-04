defmodule LabratWeb.Roles do
  @moduledoc """
    Defines roles related functions.
  """

  alias Labrat.Accounts.User
  alias Labrat.Games.Game

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  #8 can? functions
  def can?(user, entity, action)
  def can?(%User{permissions: :admin}, %Game{}, _any), do: true
  def can?(%User{}, %Game{}, :index), do: true
  def can?(%User{}, %Game{}, :show), do: true
  def can?(%User{}, %Game{}, :new), do: true
  def can?(%User{id: id}, %Game{user_id: id}, :edit), do: true
  def can?(%User{id: id}, %Game{user_id: id}, :delete), do: true
  def can?(_, _, _), do: false
end
