defmodule Br.PlayerTest do
  use Br.ModelCase, async: true 
  alias Br.Player
  import Br.TestHelpers

  @valid_attrs build_player

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Player.changeset(%Player{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Player.changeset(%Player{}, @invalid_attrs)
    refute changeset.valid?
  end
end