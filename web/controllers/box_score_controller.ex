defmodule Br.BoxScoreController do
  use Br.Web, :controller
  alias Br.BoxScore

  def upsert({player_id, player}, acc) do
    changeset = case Repo.get_by(Br.Player, player_id: player_id) do
        nil -> %Br.Player{}
        player -> player
      end
      |> Br.Player.changeset(player)

    model = case Repo.insert_or_update(changeset) do
      {:ok, model} -> model
      {:error, changeset} -> changeset
    end
    
    Map.put_new(acc, player_id, model)
  end

  def create(conn, %{"box_score" => box_score}) do
    players = Br.BoxScoreParser.get_players(box_score)
    |> Enum.reduce(%{}, &upsert/2)

    box_score = Br.BoxScoreParser.transform_data(box_score, players)
    changeset = BoxScore.changeset(%BoxScore{}, box_score)

    case Repo.insert(changeset) do
      {:ok, box_score} ->
        conn
        |> put_status(:created)
        |> render("created.json")
    end
  end

  def show(conn) do

  end 
end