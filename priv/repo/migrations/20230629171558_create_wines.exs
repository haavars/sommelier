defmodule Sommelier.Repo.Migrations.CreateWines do
  use Ecto.Migration

  def change do
    create table(:wines) do
      add :name, :string
      add :url, :string
      add :embedding, :binary

      timestamps()
    end
  end
end
