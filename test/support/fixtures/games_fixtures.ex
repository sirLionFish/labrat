defmodule Labrat.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Labrat.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        date: "some date",
        description: "some description",
        name: "some name",
        price: 42
      })
      |> Labrat.Games.create_game()

    game
  end
end
