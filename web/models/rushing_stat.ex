defmodule Br.RushingStat do
  use Br.Web, :model

  schema "rushing_stats" do
    field :yds, :integer
    field :att, :integer
    field :tds, :integer
    field :fum, :integer
    
    belongs_to :box_score, Br.BoxScore
    belongs_to :player, Br.Player

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:yds, :att, :tds, :fum])
    |> validate_required([:yds, :att, :tds, :fum])
    |> cast_assoc(:player, required: true)
  end
end