defmodule Br.PassingStatTest do
  use Br.ModelCase, async: true 
  alias Br.PassingStat
  import Br.TestHelpers

  @valid_attrs %{
    player: build_player,
    tds: 10,
    yds: 10,
    cmp: 3,
    att: 0,
    int: 0
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PassingStat.changeset(%PassingStat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PassingStat.changeset(%PassingStat{}, @invalid_attrs)
    refute changeset.valid?
  end
end