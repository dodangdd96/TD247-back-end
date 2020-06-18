defmodule BackEndWeb.JobPostController do
  use BackEndWeb, :controller
  import Ecto.Query, warn: false
  alias BackEnd.{Company, Repo, JobPost}

  def index(conn, params) do
    text_search = params["search"]

    query = from(
      jb in JobPost
    )

    query = if text_search do
      from(
        jb in query,
        where: ilike(jb.position, ^"%#{text_search}%")
      )
    else
      query
    end

    job_posts = query |> Repo.all
    render(conn, "index.json", job_posts: job_posts)
  end

	def create(conn, %{"job_post" => job_post}) do
    changeset = JobPost.changeset(%JobPost{}, job_post)
    
    case Repo.insert(changeset) do
      {:ok, job_post} ->
        conn
        |> put_status(:created)
        |> render("show.json", job_post: job_post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
	end

  def show(conn, %{"id" => id}) do
    job_post = 
      from(
        jb in JobPost,
        where: jb.id == ^id
      )
    |> Repo.one
    render(conn, "show.json", job_post: job_post)
  end

  def update(conn, params) do
    job_post = Repo.get_by!(Company, id: params["id"])
    changeset = Company.changeset(job_post, params)

    case Repo.update(changeset) do
      {:ok, job_post} ->
        render(conn, "show.json", job_post: job_post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end