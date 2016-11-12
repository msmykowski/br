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
end