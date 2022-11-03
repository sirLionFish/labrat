defmodule Labrat.GamesTest do
  use Labrat.DataCase

  alias Labrat.Games

  describe "games" do
    alias Labrat.Games.Game

    import Labrat.GamesFixtures

    @invalid_attrs %{date: nil, description: nil, name: nil, price: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{date: "some date", description: "some description", name: "some name", price: 42}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.date == "some date"
      assert game.description == "some description"
      assert game.name == "some name"
      assert game.price == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{date: "some updated date", description: "some updated description", name: "some updated name", price: 43}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.date == "some updated date"
      assert game.description == "some updated description"
      assert game.name == "some updated name"
      assert game.price == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
