defmodule Backend.TagView do
  use Backend.Web, :view

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, Backend.TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, Backend.TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      title: tag.title,
      meme_id: tag.meme_id}
  end
end
