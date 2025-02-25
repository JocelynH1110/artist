defmodule ArtistWeb.CategoriesTest do
  use Artist.DataCase

  alias Artist.Categories

  describe "categories" do
    alias Artist.Categories.Category

    import Artist.CategoriesFixtures

    @invalid_attrs %{title: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Categories.list_categories() == [category]
    end

    test "get_category/1 returns the category with given id" do
      category = category_fixture()
      assert Categories.get_category!(category.id) == category
    end

    test "get_category_by_slug/1 returns the category with given slug" do
      category = category_fixture()

      assert Categories.get_category_by_slug!(category.slug) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{
        title: "電視",
        slug: "tv"
      }

      assert {:ok, %Category{} = category} = Categories.create_category(valid_attrs)
      assert category.title == "電視"
      assert category.slug == "tv"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categories.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates a category" do
      category = category_fixture()

      update_attrs = %{
        title: "update title",
        slug: "update-slug"
      }

      assert {:ok, %Category{} = category} = Categories.update_category(category, update_attrs)
      assert category.title == "update title"
      assert category.slug == "update-slug"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()

      assert {:error, %Ecto.Changeset{}} = Categories.update_category(category, @invalid_attrs)
      assert category == Categories.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()

      assert {:ok, %Category{}} = Categories.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Categories.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()

      assert %Ecto.Changeset{} = Categories.change_category(category)
    end
  end
end
