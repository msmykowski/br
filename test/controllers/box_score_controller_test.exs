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
    
    assert response.resp_body == Poison.encode!(%{box_score: box_score_id})

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

  test "show when record is existing", %{conn: conn} do
    {:ok, player_one} = Repo.insert(%Player{} |> Map.merge(@player_one))
    {:ok, player_two} = Repo.insert(%Player{} |> Map.merge(@player_two))
    {:ok, player_three} = Repo.insert(%Player{} |> Map.merge(@player_three))

    {:ok, box_score} = Repo.insert(%BoxScore{
      timestamp: Ecto.DateTime.cast!("2014-10-02T11:00:14.682Z"),
      week: 4,
      sport_name: "Football",
      competition_name: "NFL_Reg",
      season_id: "NFL_2014"})

    rushing_stat = build_stat("Rushing", %{box_score_id: box_score.id, player_id: player_one.id}) 
    Repo.insert(%RushingStat{} |> Map.merge(rushing_stat))
    receiving_stat = build_stat("Receiving", %{box_score_id: box_score.id, player_id: player_one.id})
    Repo.insert(%ReceivingStat{} |> Map.merge(receiving_stat))
    passing_stat = build_stat("Passing", %{box_score_id: box_score.id, player_id: player_three.id})
    Repo.insert(%PassingStat{} |> Map.merge(passing_stat))
    kicking_stat = build_stat("Kicking", %{box_score_id: box_score.id, player_id: player_two.id})
    Repo.insert(%KickingStat{} |> Map.merge(kicking_stat))

    response = get conn, box_score_path(conn, :show, box_score.id, players: [player_one.id, player_two.id])
    assert response.status == 200
    assert response.resp_body == Poison.encode!(%{
      kicking: [Map.merge(kicking_stat, @player_two) |> Map.delete(:box_score_id)], 
      passing: [],
      receiving: [Map.merge(receiving_stat, @player_one) |> Map.delete(:box_score_id)],
      rushing: [Map.merge(rushing_stat, @player_one) |> Map.delete(:box_score_id)]})
  end
end

