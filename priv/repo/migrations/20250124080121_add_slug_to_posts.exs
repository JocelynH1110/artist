defmodule Artist.Repo.Migrations.AddSlugToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :slug, :string, null: false
    end

    create unique_index(:posts, [:slug])
  end
end
