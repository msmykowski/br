defmodule Br.BoxScoreParser do
  @player_attrs ["rushing", "receiving", "passing", "kicking"]

  def get_players(box_score) do
    box_score
    |> Map.take(@player_attrs)
    |> Map.values
    |> List.flatten
    |> Enum.reduce(%{}, &key_by_player_id/2)
  end

  defp key_by_player_id(stat, acc) do
    player = stat
      |> Map.take(["player_id", "entry_id", "name", "position"])

    Map.put_new(acc, player["player_id"], player)
  end

  def transform_data(box_score, players) do
    box_score
    |> Enum.into(%{}, fn {key, value} ->
      cond do
        key in ["rushing", "receiving", "passing", "kicking"] ->
          value = Enum.map(value, transform_stat(players))
          {"#{key}_stats", value}

        true -> {Phoenix.Naming.underscore(key), value}
      end
    end)
  end

  defp transform_stat(players) do
    fn
      value ->
        player = players[value["player_id"]]
        value
        |> Map.put("player", player)
        |> Map.drop(["player_id", "entry_id", "name", "position"])
    end
  end
end