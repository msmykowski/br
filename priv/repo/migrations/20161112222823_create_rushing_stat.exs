defmodule Br.Repo.Migrations.CreateRushingStat do
  use Ecto.Migration

  def change do
    create table(:rushing_stats) do
      add :att, :integer
      add :tds, :integer
      add :fum, :integer
      add :box_score_id, references(:box_scores)
      add :player_id, references(:players)
      
      timestamps
    end
  end
end
