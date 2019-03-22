defmodule Sustentation.Issues.Category do
  use Ecto.Schema
  import Ecto.Changeset


  schema "categories" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
