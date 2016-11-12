defmodule Br.Repo.Migrations.CreatePassingStat do
  use Ecto.Migration

  def change do
    create table(:passing_stats) do
      add :yds, :integer
      add :att, :integer
      add :tds, :integer
      add :cmp, :integer
      add :int, :integer
      add :box_score_id, references(:box_scores)
      add :player_id, references(:players)
      
      timestamps
    end
  end
end
