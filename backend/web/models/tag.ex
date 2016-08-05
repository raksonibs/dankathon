defmodule Backend.Tag do
  use Backend.Web, :model

  schema "tags" do
    field :title, :string
    many_to_many :memes, Backend.Meme, join_through: "memes_tags"

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
    from t in query, order_by: t.name
  end

  def names_and_ids(query) do 
    from t in query, select: {t.name, t.id}
  end
end
