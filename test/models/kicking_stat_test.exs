defmodule Br.KickingStatTest do
  use Br.ModelCase, async: true 
  alias Br.KickingStat
  import Br.TestHelpers

  @valid_attrs %{
    player: build_player,
    fld_goals_made: 10,
    fld_goals_att: 10,
    extra_pt_made: 10,
    extra_pt_att: 3
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = KickingStat.changeset(%KickingStat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = KickingStat.changeset(%KickingStat{}, @invalid_attrs)
    refute changeset.valid?
  end
end