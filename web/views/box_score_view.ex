defmodule Br.BoxScoreView do
  use Br.Web, :view

  def render("created.json", %{id: id}) do
    %{box_score: id}
  end

  def render("show.json", %{box_score: box_score}) do
    box_score
    |> Map.take([:rushing_stats, :receiving_stats, :passing_stats, :kicking_stats])
    |> Enum.reduce(%{}, &serialize_stats/2)
  end

  defp serialize_stats({key, value}, acc) do
    value = 
      value
      |> Enum.map(&serialize_stat/1)

    key = 
      key
      |> Atom.to_string
      |> String.split("_")
      |> List.first
      |> String.to_atom

    Map.put(acc, key, value) 
  end

  defp serialize_stat(stat) do
    {%{player: player}, stat} = 
      stat
      |> Map.from_struct
      |> Map.drop([:id, :updated_at, :inserted_at, :box_score, :box_score_id, :player_id, :__meta__])
      |> Map.split([:player])

    Map.merge(player, stat)
  end
end