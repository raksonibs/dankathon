defmodule Backend.MemeControllerTest do
  use Backend.ConnCase

  alias Backend.Meme
  alias Backend.Repo

  @valid_attrs %{image: "some content", rating: 42, title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do
    %{}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, meme_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    meme = Repo.insert! %Meme{}
    conn = get conn, meme_path(conn, :show, meme)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{meme.id}"
    assert data["type"] == "meme"
    assert data["attributes"]["title"] == meme.title
    assert data["attributes"]["image"] == meme.image
    assert data["attributes"]["rating"] == meme.rating
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, meme_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, meme_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "meme",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Meme, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, meme_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "meme",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    meme = Repo.insert! %Meme{}
    conn = put conn, meme_path(conn, :update, meme), %{
      "meta" => %{},
      "data" => %{
        "type" => "meme",
        "id" => meme.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Meme, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    meme = Repo.insert! %Meme{}
    conn = put conn, meme_path(conn, :update, meme), %{
      "meta" => %{},
      "data" => %{
        "type" => "meme",
        "id" => meme.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    meme = Repo.insert! %Meme{}
    conn = delete conn, meme_path(conn, :delete, meme)
    assert response(conn, 204)
    refute Repo.get(Meme, meme.id)
  end

end
