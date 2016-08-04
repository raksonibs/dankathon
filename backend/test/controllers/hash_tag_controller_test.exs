defmodule Backend.HashTagControllerTest do
  use Backend.ConnCase

  alias Backend.HashTag
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hash_tag_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    hash_tag = Repo.insert! %HashTag{}
    conn = get conn, hash_tag_path(conn, :show, hash_tag)
    assert json_response(conn, 200)["data"] == %{"id" => hash_tag.id,
      "title" => hash_tag.title,
      "meme_id" => hash_tag.meme_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, hash_tag_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, hash_tag_path(conn, :create), hash_tag: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(HashTag, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hash_tag_path(conn, :create), hash_tag: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    hash_tag = Repo.insert! %HashTag{}
    conn = put conn, hash_tag_path(conn, :update, hash_tag), hash_tag: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(HashTag, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    hash_tag = Repo.insert! %HashTag{}
    conn = put conn, hash_tag_path(conn, :update, hash_tag), hash_tag: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    hash_tag = Repo.insert! %HashTag{}
    conn = delete conn, hash_tag_path(conn, :delete, hash_tag)
    assert response(conn, 204)
    refute Repo.get(HashTag, hash_tag.id)
  end
end
