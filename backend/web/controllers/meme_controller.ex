defmodule Backend.MemeController do
  use Backend.Web, :controller

  alias Backend.Meme
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    memes = Repo.all(Meme)
    render(conn, "index.json", data: memes)
  end

  def create(conn, %{"data" => data = %{"type" => "meme", "attributes" => _meme_params}}) do
    changeset = Meme.changeset(%Meme{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, meme} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", meme_path(conn, :show, meme))
        |> render("show.json", data: meme)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Backend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meme = Repo.get!(Meme, id)
    render(conn, "show.json", data: meme)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "meme", "attributes" => _meme_params}}) do
    meme = Repo.get!(Meme, id)
    changeset = Meme.changeset(meme, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, meme} ->
        render(conn, "show.json", data: meme)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Backend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meme = Repo.get!(Meme, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(meme)

    send_resp(conn, :no_content, "")
  end

end
