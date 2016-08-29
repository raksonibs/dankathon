defmodule Backend.MemeView do
  alias Rumbl.Repo
  use Backend.Web, :view
  use JaSerializer.PhoenixView
  require IEx

  attributes [:title, :image, :rating, :inserted_at, :updated_at]
  has_many :tags
  has_many :hash_tags

end
