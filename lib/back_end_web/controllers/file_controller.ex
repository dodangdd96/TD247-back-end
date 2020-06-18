defmodule BackEndWeb.FileController do
  use BackEndWeb, :controller
  import Ecto.Query, warn: false
  alias BackEnd.{Company, Repo, File}

  def index(conn, params) do
    text_search = params["search"]

    query = from(
      f in File
    )

    query = if text_search do
      from(
        f in query,
        where: ilike(f.position, ^"%#{text_search}%")
      )
    else
      query
    end

    files = query |> Repo.all
    render(conn, "index.json", files: files)
  end

	def create(conn, %{"file" => file}) do
    changeset = File.changeset(%File{}, file)
    
    case Repo.insert(changeset) do
      {:ok, file} ->
        conn
        |> put_status(:created)
        |> render("show.json", file: file)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
	end

  def show(conn, %{"id" => id}) do
    file = 
      from(
        f in File,
        where: f.id == ^id
      )
    |> Repo.one
    render(conn, "show.json", file: file)
  end

  def update(conn, params) do
    file = Repo.get_by!(Company, id: params["id"])
    changeset = Company.changeset(file, params)

    case Repo.update(changeset) do
      {:ok, file} ->
        render(conn, "show.json", file: file)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end