defmodule Backend.HashTagTest do
  use Backend.ModelCase

  alias Backend.HashTag

  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = HashTag.changeset(%HashTag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = HashTag.changeset(%HashTag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
