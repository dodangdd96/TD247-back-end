defmodule BackEndWeb.SavedJobView do
  use BackEndWeb, :view

  alias BackEnd.{Tools}

  def render("index.json", %{saved_jobs: saved_jobs}) do
    ret = %{success: true, data: render_many(saved_jobs, __MODULE__, "saved_job.json")}
  end

  def render("show.json", %{saved_job: saved_job}) do
    %{success: true, data: render_one(saved_job, __MODULE__, "saved_job.json")}
  end

  def render("applied.json", %{saved_job: saved_job}) do
    job = if Tools.assoc_loaded?(saved_job.job),do: render_many(saved_job.job, __MODULE__, "job.json", as: :job)
		saved_job = %{
			id: saved_job.id
		}
		|> Map.put(:job, job)
  end

	def render("job.json", %{job: job}) do
		%{
			id: job.id
		}
  end
end