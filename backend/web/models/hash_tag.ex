defmodule Backend.HashTag do
  use Backend.Web, :model

  schema "hash_tags" do
    field :title, :string
    many_to_many :memes, Backend.Meme, join_through: "memes_hash_tags", on_delete: :delete_all, on_replace: :delete

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

  def alphabetical(query) do 
    from t in query, order_by: t.title
  end

  def titles_and_ids(query) do 
    from t in query, select: {t.title, t.id}
  end
end
