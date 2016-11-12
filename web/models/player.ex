defmodule Br.Player do
  use Br.Web, :model

  schema "players" do
    field :player_id, :string
    field :entry_id, :string
    field :name, :string
    field :position, :string

    has_many :rushing_stats, RushingStat
    has_many :receiving_stats, ReceivingStat
    has_many :passing_stats, PassingStat
    has_many :kicking_stats, KickingStat
  end
end