defmodule SustentationWeb.UserControllerTest do
  use SustentationWeb.ConnCase
  use SustentationWeb.AuthCase

  alias Sustentation.Auth.User

  @create_attrs %{
    password: "some encrypted_password",
    login: "some login"
  }
  @update_attrs %{
    password: "some updated encrypted_password",
    login: "some updated login"
  }
  @invalid_attrs %{encrypted_password: nil, login: nil}

  describe "index" do
    test "lists all users", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :index))

      assert json_response(conn, 200) ==
               render_json(SustentationWeb.UserView, "index.json", %{users: [user]})
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "login" => "some login"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "login" => "some updated login"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end
end
