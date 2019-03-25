defmodule SustentationWeb.CategoryController do
  use SustentationWeb, :controller

  alias Sustentation.Issues
  alias Sustentation.Issues.Category

  action_fallback SustentationWeb.FallbackController

  def index(conn, _params) do
    categories = Issues.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, category_params) do
    with {:ok, %Category{} = category} <- Issues.create_category(category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Category{} = category} <- Issues.get_category(id) do
      render(conn, "show.json", category: category)
    end
  end

  def update(conn, %{"id" => id} = category_params) do
    with {:ok, %Category{} = category} <- Issues.get_category(id),
         {:ok, %Category{} = category} <- Issues.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Category{} = category} <- Issues.get_category(id),
         {:ok, %Category{}} <- Issues.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
