defmodule BackEndWeb.SavedFileController do
  use BackEndWeb, :controller
  import Ecto.Query, warn: false
  alias BackEnd.{Repo, SavedFile}

  def index(conn, params) do
    user_id = params["user_id"]

    query = from(
      sf in SavedFile,
      where: sf.account_id == ^user_id,
      preload: [:file]
    )

    saved_files = query |> Repo.all
    render(conn, "index.json", saved_files: saved_files)
  end

	def create(conn, %{"saved_file" => saved_file}) do
    changeset = SavedFile.changeset(%SavedFile{}, saved_file)
    
    case Repo.insert(changeset) do
      {:ok, saved_file} ->
        conn
        |> put_status(:created)
        |> render("show.json", saved_file: saved_file)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
	end

  def show(conn, %{"id" => id}) do
    saved_file = 
      from(
        sf in SavedFile,
        where: sf.id == ^id
      )
    |> Repo.one
    render(conn, "show.json", saved_file: saved_file)
  end

  def update(conn, params) do
    saved_file = Repo.get_by!(SavedFile, id: params["id"])
    changeset = saved_file.changeset(saved_file, params)

    case Repo.update(changeset) do
      {:ok, saved_file} ->
        render(conn, "show.json", saved_file: saved_file)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end