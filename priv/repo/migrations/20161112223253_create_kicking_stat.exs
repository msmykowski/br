defmodule Br.Repo.Migrations.CreateKickingStat do
  use Ecto.Migration

  def change do
    create table(:kicking_stats) do
      add :fld_goals_made, :integer
      add :fld_goals_att, :integer
      add :extra_pt_made, :integer
      add :extra_pt_att, :integer
      add :box_score_id, references(:box_scores)
      add :player_id, references(:players)
      
      timestamps
    end
  end
end
