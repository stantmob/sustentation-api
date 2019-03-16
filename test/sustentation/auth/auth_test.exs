defmodule Sustentation.AuthTest do
  import Sustentation.Factories

  use Sustentation.DataCase

  alias Sustentation.Auth

  describe "users" do
    alias Sustentation.Auth.User

    setup do
      user = insert(:user)
      {:ok, user: user}
    end

    @valid_attrs %{password: "some encrypted_password", login: "some login"}
    @update_attrs %{password: "some updated encrypted_password", login: "some updated login"}
    @invalid_attrs %{password: nil, login: nil}

    test "list_users/0 returns all users", %{user: user} do
      assert Auth.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id", %{user: user} do
      assert Auth.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.password == "some encrypted_password"
      assert user.login == "some login"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user", %{user: user} do
      assert {:ok, %User{} = user} = Auth.update_user(user, @update_attrs)
      assert user.password == "some updated encrypted_password"
      assert user.login == "some updated login"
    end

    test "update_user/2 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert user == Auth.get_user!(user.id)
    end

    test "delete_user/1 deletes the user", %{user: user} do
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset", %{user: user} do
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end

    test "verify_login/1 returns ok with correct credentials", %{user: user} do
      credentials = %{"login" => user.login, "password" => "senhasenha"}
      assert Auth.verify_login(credentials) == {:ok, user}
    end

    test "verify_login/1 returns error with wrong login" do
      credentials = %{"login" => "wrong_login", "password" => ""}
      assert Auth.verify_login(credentials) == {:error, :unauthorized}
    end

    test "verify_login/1 returns error with wrong password", %{user: user} do
      credentials = %{"login" => user.login, "password" => "wrong_password"}
      assert Auth.verify_login(credentials) == {:error, :unauthorized}
    end
  end
end
