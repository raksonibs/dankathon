defmodule Backend.Repo.Migrations.CreateHashTag do
  use Ecto.Migration

  def change do
    create table(:hash_tags) do
      add :title, :string
      add :meme_id, references(:memes, on_delete: :nothing)

      timestamps()
    end
    create index(:hash_tags, [:meme_id])

  end
end
