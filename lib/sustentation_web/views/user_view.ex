defmodule SustentationWeb.UserView do
  use SustentationWeb, :view
  alias SustentationWeb.UserView

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("auth.json", %{token: token, user: user}) do
    %{token: token, user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, login: user.login}
  end
end
