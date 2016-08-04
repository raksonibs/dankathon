defmodule Backend.Tag do
  use Backend.Web, :model

  schema "tags" do
    field :title, :string
    belongs_to :meme, Backend.Meme

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
