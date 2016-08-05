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

  def count_tags() do 
    Repo.one from u in Meme,
            join: v in assoc(u, :tags),
            join: h in assoc(u, :hash_tags),
            select: count(v + h)
    # select: {v, h}
  end

  def meme_count(query) do 
    from u in query, select: count(u.id)
  end
end
