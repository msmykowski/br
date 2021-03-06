defmodule Br.ReceivingStat do
  use Br.Web, :model

  schema "receiving_stats" do
    field :yds, :integer
    field :tds, :integer
    field :rec, :integer
    
    belongs_to :box_score, Br.BoxScore
    belongs_to :player, Br.Player

    timestamps
  end

  def changeset(model, params) do
    model
    |> cast(params, [:yds, :tds, :rec])
    |> validate_required([:yds, :tds, :rec])
    |> put_assoc(:player, params["player"])
  end
end