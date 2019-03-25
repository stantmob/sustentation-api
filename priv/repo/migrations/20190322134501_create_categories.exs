defmodule Sustentation.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, size: 254, null: false
      add :description, :string, size: 10000

      timestamps()
    end
  end
end
