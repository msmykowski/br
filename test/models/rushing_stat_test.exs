defmodule Br.RushingStatTest do
  use Br.ModelCase, async: true 
  alias Br.RushingStat
  import Br.TestHelpers

  @valid_attrs %{
    player: build_player,
    yds: 10,
    att: 3,
    tds: 0,
    fum: 1
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RushingStat.changeset(%RushingStat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RushingStat.changeset(%RushingStat{}, @invalid_attrs)
    refute changeset.valid?
  end
end