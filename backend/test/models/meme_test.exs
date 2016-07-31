defmodule Backend.MemeTest do
  use Backend.ModelCase

  alias Backend.Meme

  @valid_attrs %{image: "some content", rating: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meme.changeset(%Meme{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meme.changeset(%Meme{}, @invalid_attrs)
    refute changeset.valid?
  end
end
