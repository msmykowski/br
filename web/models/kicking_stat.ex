defmodule Br.KickingStat do
  use Br.Web, :model

  schema "kicking_stats" do
    field :fld_goals_made, :integer
    field :fld_goals_att, :integer
    field :extra_pt_made, :integer
    field :extra_pt_att, :integer
    
    belongs_to :box_score, Br.BoxScore
    belongs_to :player, Br.Player

    timestamps
  end

  def changeset(model, params) do
    model
    |> cast(params, [:fld_goals_made, :fld_goals_att, :extra_pt_made, :extra_pt_att])
    |> validate_required([:fld_goals_made, :fld_goals_att, :extra_pt_made, :extra_pt_att])
    |> put_assoc(:player, params["player"])
  end
end