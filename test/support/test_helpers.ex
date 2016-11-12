defmodule Br.TestHelpers do

  def build_player(attrs \\ %{}) do
    Dict.merge(%{
      player_id: "random-id",
      entry_id: "random-entry-id",
      name: "some-name",
      position: "RB"
    }, attrs)
  end

  def build_stat(type, attrs \\ %{})

  def build_stat("Rushing", attrs) do
    Dict.merge(%{
      yds: 5,
      att: 5,
      tds: 1,
      fum: 1
    }, attrs)
  end

  def build_stat("Receiving", attrs) do
    Dict.merge(%{
      yds: 5,
      tds: 1,
      rec: 1
    }, attrs)
  end

  def build_stat("Passing", attrs) do
    Dict.merge(%{
      yds: 5,
      att: 5,
      tds: 1,
      cmp: 1,
      int: 1
    }, attrs)
  end

  def build_stat("Kicking", attrs) do
    Dict.merge(%{
      fld_goals_made: 5,
      fld_goals_att: 5,
      extra_pt_made: 5,
      extra_pt_att: 6
    }, attrs)
  end
end