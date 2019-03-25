defmodule Sustentation.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, size: ?, null: false
      add :description, :string, size: ?

      timestamps()
    end

  end
end
