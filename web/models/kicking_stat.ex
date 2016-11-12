defmodule Br.KickingStat do
  use Br.Web, :model

  schema "kicking_stats" do
    field :fld_goals_made, :integer
    field :fld_goals_att, :integer
    field :extra_point_made, :integer
    field :extra_point_att, :integer
    
    belongs_to :box_score, Br.BoxScore
    belongs_to :player, Br.Player
  end
end