defmodule SustentationWeb.UserController do
  use SustentationWeb, :controller

  alias Sustentation.Auth
  alias Sustentation.Auth.User

  action_fallback SustentationWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)

    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def authenticate(conn, params) do
    with {:ok, user} <- Sustentation.Auth.verify_login(params),
         {:ok, token, _full_claims} <- Guardian.encode_and_sign(user, %{}) do
      conn |> render("auth.json", token: token, user: user)
    end
  end

  @doc """
  Called when there is an authorization error.

  Calls `OccurrencesWeb.FallbackController.call/2` to render the unauthorized
  error message.

  This is used on the authorization step, when the user is trying to perform
  an action that is restricted and it fails to pass a valid `Authorization`
  header with a valid token.

  """

  def auth_error(conn, {_type, _reason}, _opts) do
    SustentationWeb.FallbackController.call(conn, {:error, :unauthorized})
  end
end
