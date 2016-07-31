defmodule Backend.Repo.Migrations.CreateMeme do
  use Ecto.Migration

  def change do
    create table(:memes) do
      add :title, :string
      add :image, :string
      add :rating, :integer

      timestamps()
    end

  end
end
