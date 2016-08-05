defmodule Backend.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :title, :string, null: false
      add :meme_id, references(:memes, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:tags, [:title])
    create index(:tags, [:meme_id])

  end
end
