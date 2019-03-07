defmodule SustentationWeb.AuthCase do
  @moduledoc """
  This module defines the test case to be used by tests that require
  user authentication.

  Modules that *use* AuthCase will have a Company, Construction Site,
  Person and User, all associated, available for all tests. It will
  also have an `authorization` token on the header. That is required
  for most endpoints.
  """

  use ExUnit.CaseTemplate

  import Plug.Conn, only: [put_req_header: 3]
  import Sustentation.Factories

  setup %{conn: conn} do
    user = insert(:user)
    {:ok, token, _full_claims} = Sustentation.Guardian.encode_and_sign(user)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn, user: user}
  end
end
