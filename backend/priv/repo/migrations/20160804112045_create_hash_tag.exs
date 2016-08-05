defmodule Backend.Repo.Migrations.CreateHashTag do
  use Ecto.Migration

  def change do
    create table(:hash_tags) do
      add :title, :string, null: false
      add :meme_id, references(:memes, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:hash_tags, [:title])
    create index(:hash_tags, [:meme_id])

  end
end
