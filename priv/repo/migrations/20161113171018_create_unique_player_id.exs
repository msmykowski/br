defmodule Br.Repo.Migrations.CreateUniquePlayerId do
  use Ecto.Migration

  def change do
    create unique_index(:players, [:player_id, :entry_id])
  end
end
