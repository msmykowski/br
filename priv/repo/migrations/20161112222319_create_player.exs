defmodule Br.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :player_id, :string
      add :entry_id, :string
      add :name, :string
      add :position, :string
      
      timestamps
    end
  end
end