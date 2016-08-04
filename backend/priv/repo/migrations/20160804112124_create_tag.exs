defmodule Backend.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :title, :string
      add :meme_id, references(:memes, on_delete: :nothing)

      timestamps()
    end
    create index(:tags, [:meme_id])

  end
end
