defmodule Br.ReceivingStatTest do
  use Br.ModelCase, async: true 
  alias Br.ReceivingStat
  import Br.TestHelpers

  @valid_attrs %{
    player: build_player,
    tds: 10,
    yds: 3,
    rec: 0
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ReceivingStat.changeset(%ReceivingStat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ReceivingStat.changeset(%ReceivingStat{}, @invalid_attrs)
    refute changeset.valid?
  end
end