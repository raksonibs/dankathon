defmodule Backend.MemeView do
  use Backend.Web, :view
  use JaSerializer.PhoenixView

  attributes [:title, :image, :rating, :inserted_at, :updated_at]
  

end
