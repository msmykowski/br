defmodule Br.BoxScoreControllerTest do
  use Br.ConnCase
  alias Br.Repo
  alias Br.BoxScore
  alias Br.Player
  alias Br.RushingStat
  alias Br.ReceivingStat
  alias Br.PassingStat
  alias Br.KickingStat
  import Br.TestHelpers

  @player_one build_player(%{name: "player one"})
  @player_two build_player(%{name: "player two"})
  @player_three build_player(%{name: "player three"})
  @rushing_stat build_stat("Rushing")
  @receiving_stat build_stat("Receiving")
  @passing_stat build_stat("Passing")
  @kicking_stat build_stat("Kicking")

  @box_score %{
    timestamp: "2014-10-02T11:00:14.682Z",
    pollingInterval: "10",
    week: "4",
    sportName: "Football",
    competitionName: "NFL_Reg",
    seasonID: "NFL_2014",
    rushing: Dict.merge(@player_one, @rushing_stat),
    receiving: Dict.merge(@player_one, @receiving_stat),
    passing: Dict.merge(@player_two, @passing_stat),
    kicking: Dict.merge(@player_three, @kicking_stat)
  }

  test "create with a valid body", %{conn: conn} do
    response = post conn, box_score_path(conn, :create), box_score: @box_score 
    assert response.status == 201
    assert Repo.one(from b in BoxScore, select: count("*")) == 1
    #assert Repo.one(from p in Player, select: count("*")) == 3
    #assert Repo.get_by!(RushingStat, @rushing_stat).player_id == Repo.get_by!(Player, @player_one).id
    #assert Repo.get_by!(RushingStat, @rushing_stat).box_score_id == Repo.get_by!(Player, @player_one).id
    #assert Repo.get_by!(ReceivingStat, @receiving_stat).player_id == Repo.get_by!(Player, @player_one).id
    #assert Repo.get_by!(ReceivingStat, @receiving_stat).box_score_id == Repo.get_by!(Player, @player_one).id
    #assert Repo.get_by!(PassingStat, @passing_stat).player_id == Repo.get_by!(Player, @player_two).id
    #assert Repo.get_by!(PassingStat, @passing_stat).box_score_id == Repo.get_by!(Player, @player_two).id
    #assert Repo.get_by!(KickingStat, @kicking_stat).player_id == Repo.get_by!(Player, @player_three).id
    #assert Repo.get_by!(KickingStat, @kicking_stat).box_score_id == Repo.get_by!(Player, @player_three).id
  end
end