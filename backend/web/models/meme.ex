defmodule Backend.Meme do
  use Backend.Web, :model

  schema "memes" do
    field :title, :string
    field :image, :string
    field :rating, :integer

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
