require IEx

defmodule Backend.MemeController do
  import Ecto.Query, only: [from: 2]
  use Backend.Web, :controller

  alias Backend.Meme
  alias JaSerializer.Params

  alias Backend.Repo

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, params) do
    if params[:title] != "" and params[:title] != nil do
      title = params["title"]
      query = from m in Meme, where: m.title == ^title, preload: [:hash_tags, :tags]      
    else
      query = from meme in Meme, preload: [:hash_tags, :tags]
    end

    memes = Repo.all(query)
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

  def sign(conn, _params) do 
    conn
  end

  def upload(conn, params) do
    # how to do this in the phoenix way?
    # conn 
    # |> Backend.Gif.store(%Plug.Upload{})
    
    number = round(:rand.uniform * 100000)
    random_string = Integer.to_string(number, 36)
    meme_file = params["file"].filename
    meme = Repo.get_by(Meme, image: meme_file) || Repo.insert!(%Meme{image: meme_file, rating: 0, title: random_string})
    Backend.Gif.store({params["file"], meme})
    changeset = Meme.changeset(meme, %{image: Backend.Gif.url({meme_file, meme}, :original)})
    case Repo.update(changeset) do
      {:ok, meme}         -> render(conn, "show.json", data: meme)
      {:error, changeset} -> 
          conn
        |> put_status(:unprocessable_entity)
        |> render(Backend.ChangesetView, "error.json", changeset: changeset)
    end
   
  end

end
