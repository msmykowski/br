defmodule Br.Repo.Migrations.AddTimestampToBoxScore do
  use Ecto.Migration

  def change do
    alter table(:box_scores) do
      add :timestamp, :datetime
    end
  end
end
