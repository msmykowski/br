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

  def transform_data(box_score, player) do
    box_score
    |> Enum.into(%{}, fn {k, v} -> rename_keys(k, v) end)
  end

  defp rename_keys(key, value) do
    cond do
      key in ["rushing", "receiving", "passing", "kicking"] ->
        value = Enum.map(value, &transform_stat/1)
        {"#{key}_stats", value}
      true -> {Phoenix.Naming.underscore(key), value}
    end
  end

  defp transform_stat(value) do
    {player, stat} = value
      |> Map.split(["player_id", "entry_id", "name", "position"])
      
      Map.merge(%{"player" => player}, stat)
  end
end