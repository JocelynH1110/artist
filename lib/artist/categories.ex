defmodule Artist.Categories do
  import Ecto.Query, warn: false
  alias Artist.Repo
  alias Artist.Categories.Category

  alias Artist.Posts.Post
  alias Artist.PostCategories.PostCategory

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

  # 其他 Category 相關函式
  @doc """
  取得分類和該分類的所有文章，並依照
  """
  def get_category_with_posts!(id) do
    Category
    |> Repo.get!(id)
    # 預先載入與該分類關聯的所有文章，並依照字母排序
    |> Repo.preload(posts: from(p in Post, order_by: p.name))
  end

  @doc """
  取得分類和該分類的詳細文章資訊
  """
  def get_category_with_post_details!(id) do
    Category
    |> Repo.get!(id)
    |> Repo.preload(
      post_categories:
        from(pc in PostCategory,
          where:
            pc.post_id in subquery(from p in Post, where: p.published_at == true, select: p.id),
          order_by: pc.id,
          # 載入 post 資料，這樣每個 post_category 結構中都會有完整的 post 資料，可以直接用 post_category.post.title 取得文章標題
          preload: :post
        )
    )
  end

  @doc """
  查詢每個分類的文章數量
  """
  def get_category_post_counts do
    from(pc in PostCategory,
      join: p in Post,
      on: pc.post_id == p.id,
      where: p.published_at == true,
      group_by: pc.category_id,
      select: {pc.category_id, count(pc.post_id)}
    )
    # 執行查詢並取得所有結果
    |> Repo.all()
    # 將結果轉換成 map 資料結構
    |> Map.new()
  end
end
