defmodule Br.PassingStat do
  use Br.Web, :model

  schema "passing_stats" do
    field :yds, :integer
    field :tds, :integer
    field :att, :integer
    field :cmp, :integer
    field :int, :integer
    
    belongs_to :box_score, Br.BoxScore
    belongs_to :player, Br.Player

    timestamps
  end

  def changeset(model, params) do
    model
    |> cast(params, [:yds, :tds, :att, :cmp, :int])
    |> validate_required([:yds, :tds, :att, :cmp, :int])
    |> put_assoc(:player, params["player"])
  end
end