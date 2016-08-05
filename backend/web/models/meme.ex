defmodule Backend.Meme do
  use Backend.Web, :model

  schema "memes" do
    field :title, :string
    field :image, :string
    field :rating, :integer

    many_to_many :hash_tags, Backend.HashTag, join_through: "memes_hash_tags"
    many_to_many :tags, Backend.Tag, join_through: "memes_tags"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :image, :rating])
    |> validate_required([:title, :image, :rating])
  end
end
