defmodule Br.Repo.Migrations.CreateReceivingStat do
  use Ecto.Migration

  def change do
    create table(:receiving_stats) do
      add :yds, :integer
      add :tds, :integer
      add :rec, :integer
      add :box_score_id, references(:box_scores)
      add :player_id, references(:players)
      
      timestamps
    end
  end
end
