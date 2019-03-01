defmodule Sustentation.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string
      add :encrypted_password, :string

      timestamps()
    end

  end
end
