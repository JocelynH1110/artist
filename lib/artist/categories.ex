defmodule Artist.Categories do
  import Ecto.Query, warn: false
  alias Artist.Repo
  alias Artist.Categories.Category

  @doc """
  返回所有 categories 列表
  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  取得特定的 category, 若不存在返回錯誤
  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  建立一個 category
  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  更新 category,(%Category{} = category)此參數用來確保 category 是 struct 
  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  刪除 category
  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  返回 changeset{} 為了追蹤 category 的改變
  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  @doc """
  依據 slug 找文章
  """
  def get_category_by_slug!(slug) do
    Repo.get_by!(Category, slug: slug)
  end
end
