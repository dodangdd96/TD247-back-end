defmodule BackEndWeb.AppliedController do
  use BackEndWeb, :controller
  import Ecto.Query, warn: false
  alias BackEnd.{Repo, Applied}

  def index(conn, params) do
    user_id = params["user_id"]

    query = from(
      a in Applied,
      where: a.account_id == ^user_id,
      preload: [:job]
		)

    applieds = Repo.all(query)
    render(conn, "index.json", applieds: applieds)
  end

	def create(conn, params) do
    changeset = Applied.changeset(%Applied{}, params["applied"])
    
    case Repo.insert(changeset) do
      {:ok, applied} ->
        conn
        |> put_status(:created)
        |> render("show.json", applied: applied)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
	end

  def show(conn, %{"id" => id}) do
    applied = 
      from(
        a in Applied,
        where: a.id == ^id
      )
    |> Repo.one
    render(conn, "show.json", applied: applied)
  end

  def update(conn, params) do
    applied = Repo.get_by!(Applied, id: params["id"])
    changeset = Applied.changeset(applied, params)

    case Repo.update(changeset) do
      {:ok, applied} ->
        render(conn, "show.json", applied: applied)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end