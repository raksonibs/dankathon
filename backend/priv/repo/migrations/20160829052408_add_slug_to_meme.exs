defmodule Backend.Repo.Migrations.AddSlugToMeme do
  use Ecto.Migration

  def change do
    alter table(:memes) do
      add :slug, :string
    end

    create unique_index(:memes, [:slug])
  end
end
