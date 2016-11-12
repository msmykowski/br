defmodule Br.Repo.Migrations.CreateBoxScore do
  use Ecto.Migration

  def change do
    create table(:box_scores) do
      add :sport_name, :string
      add :competition_name, :string
      add :season_id, :string
      add :week, :integer
      
      timestamps
    end
  end
end
