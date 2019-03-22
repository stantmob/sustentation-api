defmodule SustentationWeb.Router do
  use SustentationWeb, :router

  alias Guardian.Plug.{EnsureAuthenticated, LoadResource, VerifyHeader}

  pipeline :api do
    plug :accepts, ["json"]

    plug(
      Guardian.Plug.Pipeline,
      module: Sustentation.Guardian,
      error_handler: SustentationWeb.UserController
    )
  end

  pipeline :authenticate do
    plug(VerifyHeader)
    plug(EnsureAuthenticated)
    plug(LoadResource)
  end

  scope "/api", SustentationWeb do
    pipe_through :api

    post("/authenticate", UserController, :authenticate)

    pipe_through :authenticate

    resources "/users", UserController, except: [:new, :edit]

    resources "/categories", CategoryController, except: [:new, :edit]
  end
end
