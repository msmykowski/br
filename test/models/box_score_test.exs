defmodule Br.BoxScoreTest do
  use Br.ModelCase, async: true 
  alias Br.BoxScore

  @valid_attrs %{
    timestamp: "2014-10-02T11:00:14.682Z",
    polling_interval: "10",
    week: "4",
    sport_name: "Football",
    competition_name: "NFL_Reg",
    season_id: "NFL_2014"
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BoxScore.changeset(%BoxScore{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BoxScore.changeset(%BoxScore{}, @invalid_attrs)
    refute changeset.valid?
  end
end