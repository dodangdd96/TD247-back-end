defmodule BackEndWeb.SavedJobController do
  use BackEndWeb, :controller
  import Ecto.Query, warn: false
  alias BackEnd.{Repo, SavedJob}

  def index(conn, params) do
    user_id = params["user_id"]

    query = from(
      sj in SavedJob,
      where: sj.account_id == ^user_id,
      preload: [:job]
    )

    saved_jobs = query |> Repo.all
    render(conn, "index.json", saved_jobs: saved_jobs)
  end

	def create(conn, %{"saved_job" => saved_job}) do
    changeset = SavedJob.changeset(%SavedJob{}, saved_job)
    
    case Repo.insert(changeset) do
      {:ok, saved_job} ->
        conn
        |> put_status(:created)
        |> render("show.json", saved_job: saved_job)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
	end

  def show(conn, %{"id" => id}) do
    saved_job = 
      from(
        sj in SavedJob,
        where: sj.id == ^id
      )
    |> Repo.one
    render(conn, "show.json", saved_job: saved_job)
  end

  def update(conn, params) do
    saved_job = Repo.get_by!(SavedJob, id: params["id"])
    changeset = SavedJob.changeset(saved_job, params)

    case Repo.update(changeset) do
      {:ok, saved_job} ->
        render(conn, "show.json", saved_job: saved_job)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end