defmodule BackEndWeb.CompanyController do
  use BackEndWeb, :controller
  import Ecto.Query, warn: false
  alias BackEnd.{Company, Repo}

  def index(conn, params) do
    text_search = params["search"]
    query = from(
      c in Company
    )

    query = if text_search do
      from(
        c in query,
        where: ilike(c.company_name, ^"%#{text_search}%")
      )
    else
      query
    end
    
    companys = query |> Repo.all
    render(conn, "index.json", companys: companys)
  end

  def show(conn, %{"id" => id}) do
    company = 
      from(
        c in Company,
        where: c.account_id == ^id
      )
    |> Repo.one

    render(conn, "show.json", company: company)
  end

  def update(conn, params) do
    company = Repo.get_by!(Company, id: params["id"])
    changeset = Company.changeset(company, params)

    case Repo.update(changeset) do
      {:ok, company} ->
        render(conn, "show.json", company: company)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(BackEndWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
end