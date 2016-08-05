defmodule Backend.HashTag do
  use Backend.Web, :model

  schema "hash_tags" do
    field :title, :string
    many_to_many :memes, Backend.Meme, join_through: "memes_hash_tags"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
