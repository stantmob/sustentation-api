defmodule SustentationWeb.Router do
  use SustentationWeb, :router

  pipeline :api do
    plug :accepts, ["json"]

    plug(
      Guardian.Plug.Pipeline,
      module: Sustentation.Guardian,
      error_handler: SustentationWeb.UserController
    )
  end

  scope "/api", SustentationWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]

    post("/authenticate", UserController, :authenticate)
  end
end
