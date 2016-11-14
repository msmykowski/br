defmodule Br.BoxScoreController do
  use Br.Web, :controller
  alias Br.BoxScore

  def create(conn, %{"box_score" => box_score}) do
    players = Br.BoxScoreParser.get_players(box_score)
    |> Enum.reduce(%{}, &upsert/2)

    box_score = Br.BoxScoreParser.transform_data(box_score, players)
    changeset = BoxScore.changeset(%BoxScore{}, box_score)

    case Repo.insert(changeset) do
      {:ok, box_score} ->
        conn
        |> put_status(:created)
        |> render("created.json", %{id: box_score.id})
      {:error, changeset} -> 
        conn
        |> put_status(422)
        |> render(Br.ErrorView, "422.json", %{errors: changeset.errors})
    end
  end

  def show(conn, %{"id" => id, "players" => players}) do
    case Repo.one(box_score_query(id, players)) do
      nil ->
        conn
        |> put_status(404)
        |> render(Br.ErrorView, "404.json")
      box_score ->
        conn
        |> put_status(:ok)
        |> render("show.json", %{box_score: box_score})
    end
  end

   defp upsert({player_id, player}, acc) do
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

  defp box_score_query(id, players) do
    player_query = from p in Br.Player, select: %{player_id: p.player_id, name: p.name, position: p.position, entry_id: p.entry_id}
    ru_query = from ru in Br.RushingStat,
      where: ru.player_id in ^players, 
      preload: [player: ^player_query]
    re_query = from re in Br.ReceivingStat, 
      where: re.player_id in ^players,
      preload: [player: ^player_query]
    pa_query = from pa in Br.PassingStat,
      where: pa.player_id in ^players,
      preload: [player: ^player_query]
    ki_query = from ki in Br.KickingStat,
      where: ki.player_id in ^players,
      preload: [player: ^player_query]
    
    from b in BoxScore,
      where: b.id == ^id,
      preload: [
        rushing_stats: ^ru_query, 
        receiving_stats: ^re_query, 
        passing_stats: ^pa_query,
        kicking_stats: ^ki_query
      ]
  end
end