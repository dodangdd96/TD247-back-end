defmodule BackEndWeb.AppliedView do
  use BackEndWeb, :view

  alias BackEnd.{Tools}

  def render("index.json", %{applieds: applieds}) do
    ret = %{success: true, data: render_many(applieds, __MODULE__, "applied.json")}
  end

  def render("show.json", %{applied: applied}) do
    %{success: true, data: render_one(applied, __MODULE__, "applied.json")}
  end

  def render("applied.json", %{applied: applied}) do
    job = if Tools.assoc_loaded?(applied.job),do: render_many(applied.job, __MODULE__, "job.json", as: :job)
		applied = %{
			id: applied.id
		}
		|> Map.put(:job, job)
  end

	def render("job.json", %{job: job}) do
		%{
			id: job.id
		}
  end
end