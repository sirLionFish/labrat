defmodule LabratWeb.Role do

  @moduledoc """
  Defines roles related functions.
  """

  alias Labrat.Accounts.User
  alias Labrat.Properties.Property

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  @spec can?(%User{}, entity(), action()) :: boolean()
  def can?(user, entity, action)
  def can?(%User{permissions: :admin}, %Property{}, _any), do: true
  def can?(%User{}, %Property{}, :index), do: true
  def can?(%User{}, %Property{}, :new), do: true
  def can?(%User{}, %Property{}, :show), do: true
  def can?(%User{id: id}, %Property{user_id: id}, :edit), do: true
  def can?(%User{id: id}, %Property{user_id: id}, :delete), do: true
  def can?(_, _, _), do: false
end
