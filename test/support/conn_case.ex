defmodule SustentationWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias SustentationWeb.Router.Helpers, as: Routes

      import SustentationWeb.ConnCase, only: [render_json: 3]
      import Sustentation.Factories

      # The default endpoint for testing
      @endpoint SustentationWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Sustentation.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Sustentation.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  @doc """
  A helper that renders the view template encoded in Elixir's map structure.
  """
  @spec render_json(module, String.t(), map) :: map
  def render_json(view, template, assigns) do
    template
    |> view.render(assigns)
    |> Jason.encode!()
    |> Jason.decode!()
  end
end
