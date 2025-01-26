defmodule Artist.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :content, :text
      add :published_at, :utc_datetime
      add :shooting_date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
