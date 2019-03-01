defmodule Sustentation.Repo do
  use Ecto.Repo,
    otp_app: :sustentation,
    adapter: Ecto.Adapters.Postgres
end
