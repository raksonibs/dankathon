defmodule Backend.Repo.Migrations.AddManyToManyForEverything do
  use Ecto.Migration

  def change do
    create table(:memes_tags, primary_key: false) do
      add :meme_id, references(:memes)
      add :tag_id, references(:tags)
    end

    create table(:memes_hash_tags, primary_key: false) do
      add :meme_id, references(:memes)
      add :hash_tag_id, references(:hash_tags)
    end
  end
end
