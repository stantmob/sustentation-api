defmodule SustentationWeb.CategoryView do
  use SustentationWeb, :view
  alias SustentationWeb.CategoryView

  def render("index.json", %{categories: categories}) do
    render_many(categories, CategoryView, "category.json")
  end

  def render("show.json", %{category: category}) do
    render_one(category, CategoryView, "category.json")
  end

  def render("category.json", %{category: category}) do
    %{id: category.id, name: category.name, description: category.description}
  end
end
