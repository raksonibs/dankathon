defmodule Backend.Gif do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition

  # Override the storage directory:
  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def acl(:thumb, _), do: :public_read
  # def __storage, do: Arc.Storage.Local

  def validate({file, _}) do   
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

   # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  def filename(version, _) do
    version
  end

  def storage_dir(_, {file, meme}) do
    "badcomics/gifs/#{meme.id}"
  end

  def default_url(:thumb) do
    "https://placehold.it/100x100"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  def s3_object_headers(version, {file, scope}) do
    [content_type: Plug.MIME.path(file.file_name)]
  end
end
