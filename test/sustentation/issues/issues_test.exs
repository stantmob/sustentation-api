defmodule Sustentation.IssuesTest do
  use Sustentation.DataCase

  alias Sustentation.Issues

  describe "categories" do
    alias Sustentation.Issues.Category

    setup do
      category = insert(:category)
      {:ok, category: category}
    end

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    test "list_categories/0 returns all categories", %{category: category} do
      assert Issues.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id", %{category: category} do
      assert Issues.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Issues.create_category(@valid_attrs)
      assert category.description == "some description"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category", %{category: category} do
      assert {:ok, %Category{} = category} = Issues.update_category(category, @update_attrs)
      assert category.description == "some updated description"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset", %{category: category} do
      assert {:error, %Ecto.Changeset{}} = Issues.update_category(category, @invalid_attrs)
      assert category == Issues.get_category!(category.id)
    end

    test "delete_category/1 deletes the category", %{category: category} do
      assert {:ok, %Category{}} = Issues.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset", %{category: category} do
      assert %Ecto.Changeset{} = Issues.change_category(category)
    end
  end
end
