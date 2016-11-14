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

  @player_one build_player(%{name: "player one", player_id: "abc"})
  @player_two build_player(%{name: "player two", player_id: "def"})
  @player_three build_player(%{name: "player three", player_id: "ghi"})
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
    rushing: [Dict.merge(@player_one, @rushing_stat)],
    receiving: [Dict.merge(@player_one, @receiving_stat)],
    passing: [Dict.merge(@player_two, @passing_stat)],
    kicking: [Dict.merge(@player_three, @kicking_stat)]
  }

  test "create with a valid body", %{conn: conn} do
    response = post conn, box_score_path(conn, :create), box_score: @box_score 
    assert response.status == 201

    assert Repo.one(from b in BoxScore, select: count("*")) == 1
    assert Repo.one(from p in Player, select: count("*")) == 3

    box_score_id = Repo.get_by!(BoxScore, timestamp: @box_score.timestamp).id
    player_one_id = Repo.get_by!(Player, @player_one).id
    player_two_id = Repo.get_by!(Player, @player_two).id
    player_three_id = Repo.get_by!(Player, @player_three).id

    rushing_stat = Repo.get_by!(RushingStat, @rushing_stat);
    assert rushing_stat.player_id == player_one_id
    assert rushing_stat.box_score_id == box_score_id

    receiving_stat = Repo.get_by!(ReceivingStat, @receiving_stat);
    assert receiving_stat.player_id == player_one_id
    assert receiving_stat.box_score_id == box_score_id

    passing_stat = Repo.get_by!(PassingStat, @passing_stat);
    assert passing_stat.player_id == player_two_id
    assert passing_stat.box_score_id == box_score_id

    kicking_stat = Repo.get_by!(KickingStat, @kicking_stat)
    assert kicking_stat.player_id == player_three_id
    assert kicking_stat.box_score_id == box_score_id
  end

  test "get /:season_id/:week", %{conn: conn} do
    box_score = Repo.insert(BoxScore, %{
      timestamp: "2014-10-02T11:00:14.682Z",
      pollingInterval: "10",
      week: "4",
      sportName: "Football",
      competitionName: "NFL_Reg",
      seasonID: "NFL_2014"})

    box_score_two = Repo.insert(BoxScore, %{
      timestamp: "2014-10-02T11:00:14.682Z",
      pollingInterval: "10",
      week: "5",
      sportName: "Football",
      competitionName: "NFL_Reg",
      seasonID: "NFL_2014"})

      player_one = Repo.insert(@player_one)
      player_two = Repo.insert(@player_two)
      player_three = Repo.insert(@player_three)

      rushing_stat_one = Repo.insert(RushingStat, build_stat("Rushing", %{box_score_id: box_score.id, player_id: player_one.id}))
      receiving_stat_one = Repo.insert(ReceivingStat, build_stat("Receiving", %{box_score_id: box_score.id, player_id: player_one.id}))
      receiving_stat_two = Repo.insert(ReceivingStat, build_stat("Receiving", %{box_score_id: box_score.id, player_id: player_two.id}))
      receiving_stat_three = Repo.insert(ReceivingStat, build_stat("Receiving", %{box_score_id: box_score.id, player_id: player_three.id}))
      passing_stat_one = Repo.insert(PassingStat, build_stat("Passing", %{box_score_id: box_score.id, player_id: player_three.id}))
      kicking_stat_one = Repo.insert(KickingStat, build_stat("Kicking", %{box_score_id: box_score.id, player_id: player_two.id}))

      Repo.insert(RushingStat, build_stat("Rushing", %{yds: 1, box_score_id: box_score_two.id, player_id: player_one.id}))
      Repo.insert(ReceivingStat, build_stat("Receiving", %{yds: 1, box_score_id: box_score_two.id, player_id: player_one.id}))
      Repo.insert(ReceivingStat, build_stat("Receiving", %{yds: 1, box_score_id: box_score_two.id, player_id: player_two.id}))
      Repo.insert(ReceivingStat, build_stat("Receiving", %{yds: 1, box_score_id: box_score_two.id, player_id: player_three.id}))
      Repo.insert(PassingStat, build_stat("Passing", %{yds: 1, box_score_id: box_score_two.id, player_id: player_three.id}))
      Repo.insert(KickingStat, build_stat("Kicking", %{fld_goals_made: 1, box_score_id: box_score_two.id, player_id: player_two.id}))

      response = get conn, box_score_path(conn, :show, box_score)
      assert response.status == 200
      assert response.body == %{
        "rushing": [Dict.merge(@player_one, rushing_stat_one)],
        "receiving": [
          Dict.merge(@player_one, receiving_stat_one),
          Dict.merge(@player_two, receiving_stat_two)
        ],
        "passing": [],
        "kicking": [Dict.merge(@player_two, kicking_stat_one)]
      }
  end
end