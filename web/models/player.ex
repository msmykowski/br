defmodule Br.Player do
  use Br.Web, :model

  schema "players" do
    field :player_id, :string
    field :entry_id, :string
    field :name, :string
    field :position, :string

    has_many :rushing_stats, Br.RushingStat
    has_many :receiving_stats, Br.ReceivingStat
    has_many :passing_stats, Br.PassingStat
    has_many :kicking_stats, Br.KickingStat

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:player_id, :entry_id, :name, :position])
    |> validate_required([:player_id, :entry_id, :name, :position])
    |> unique_constraint(:player_id, :entry_id)
  end
end