defmodule Br.Repo.Migrations.AddYdsToRushingStat do
  use Ecto.Migration

  def change do
    alter table(:rushing_stats) do
      add :yds, :integer
    end
  end
end
