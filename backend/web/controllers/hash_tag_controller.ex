defmodule Backend.HashTagController do
  use Backend.Web, :controller

  alias Backend.HashTag

  def index(conn, _params) do
    hash_tags = Repo.all(HashTag)
    render(conn, "index.json", hash_tags: hash_tags)
  end

  def create(conn, %{"hash_tag" => hash_tag_params}) do
    changeset = HashTag.changeset(%HashTag{}, hash_tag_params)

    case Repo.insert(changeset) do
      {:ok, hash_tag} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", hash_tag_path(conn, :show, hash_tag))
        |> render("show.json", hash_tag: hash_tag)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Backend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hash_tag = Repo.get!(HashTag, id)
    render(conn, "show.json", hash_tag: hash_tag)
  end

  def update(conn, %{"id" => id, "hash_tag" => hash_tag_params}) do
    hash_tag = Repo.get!(HashTag, id)
    changeset = HashTag.changeset(hash_tag, hash_tag_params)

    case Repo.update(changeset) do
      {:ok, hash_tag} ->
        render(conn, "show.json", hash_tag: hash_tag)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Backend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hash_tag = Repo.get!(HashTag, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(hash_tag)

    send_resp(conn, :no_content, "")
  end
end
