defmodule Br.BoxScore do
  use Br.Web, :model

  schema "box_scores" do
    field :timestamp, Ecto.DateTime
    field :sport_name, :string
    field :competition_name, :string
    field :season_id, :string
    field :week, :integer
    
    has_many :rushing_stats, RushingStat
    has_many :receiving_stats, ReceivingStat
    has_many :passing_stats, PassingStat
    has_many :kicking_stats, KickingStat
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:timestamp, :sport_name, :competition_name, :season_id, :week])
    |> validate_required([:timestamp, :sport_name, :competition_name, :season_id, :week])
  end
end