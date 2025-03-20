defmodule Artist.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Artist.Repo

  alias Artist.Posts.Post
  alias Artist.Categories.Category
  alias Artist.PostCategories.PostCategory

  @doc """
   依據 slug 找文章
  """
  def get_post_by_slug!(slug) do
    Repo.get_by!(Post, slug: slug)
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  # 其他 Post 相關函式
  @doc """
  Gets a post and all its related categories, with those categories sorted alphabetically by name.
  """
  def get_post_with_categories!(id) do
    Post
    |> Repo.get!(id)
    |> Repo.preload(categories: from(c in Category, order_by: c.name))
  end

  @doc """
  Add category to post
  """
  def add_category_to_post(%Post{} = post, %Category{} = category, attrs \\ %{}) do
    %PostCategory{}
    |> PostCategory.changeset(
      Map.merge(attrs, %{
        post_id: post.id,
        category_id: category.id
      })
    )
    |> Repo.insert()
  end

  def update_post_category(%PostCategory{} = post_category, attrs) do
    post_category
    |> PostCategory.changeset(attrs)
    |> Repo.update()
  end

  def remove_category_from_post(%Post{} = post, %Category{} = category) do
    from(pc in PostCategory, where: pc.post_id == ^post.id and pc.category_id == ^category.id)
    |> Repo.delete_all()
  end
end
