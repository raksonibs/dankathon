defmodule Backend.MemeView do
  alias Rumbl.Repo
  use Backend.Web, :view
  use JaSerializer.PhoenixView

  attributes [:title, :image, :rating, :inserted_at, :updated_at]
  has_many :tags, include: true, type: "tags"
  has_many :hash_tags, include: true, type: "hash-tags"

  # def hash_tags(model, conn) do 
  #   case model.hash_tags do 
  #     %Ecto.Association.NotLoaded{} -> 
  #         model
  #         |> Ecto.Model.assoc(:Hash_tags)
  #         |> Repo.all
  #     _ -> 
  #       model
  #   end
  # end

  # Repo.preload created_meme, [:tags, :hash_tags]
end
