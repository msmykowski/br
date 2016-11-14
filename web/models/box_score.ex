defmodule Br.BoxScore do
  use Br.Web, :model

  schema "box_scores" do
    field :timestamp, Ecto.DateTime
    field :sport_name, :string
    field :competition_name, :string
    field :season_id, :string
    field :week, :integer
    
    has_many :rushing_stats, Br.RushingStat
    has_many :receiving_stats, Br.ReceivingStat
    has_many :passing_stats, Br.PassingStat
    has_many :kicking_stats, Br.KickingStat

    timestamps
  end

  def changeset(model, params) do
    model
    |> cast(params, [:timestamp, :sport_name, :competition_name, :season_id, :week])
    |> validate_required([:timestamp, :sport_name, :competition_name, :season_id, :week])
    |> cast_assoc(:rushing_stats)
    |> cast_assoc(:receiving_stats)
    |> cast_assoc(:passing_stats)
    |> cast_assoc(:kicking_stats)
  end
end