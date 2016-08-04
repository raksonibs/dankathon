defmodule Backend.HashTagView do
  use Backend.Web, :view

  def render("index.json", %{hash_tags: hash_tags}) do
    %{data: render_many(hash_tags, Backend.HashTagView, "hash_tag.json")}
  end

  def render("show.json", %{hash_tag: hash_tag}) do
    %{data: render_one(hash_tag, Backend.HashTagView, "hash_tag.json")}
  end

  def render("hash_tag.json", %{hash_tag: hash_tag}) do
    %{id: hash_tag.id,
      title: hash_tag.title,
      meme_id: hash_tag.meme_id}
  end
end
