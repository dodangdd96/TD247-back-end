defmodule BackEndWeb.SavedFileView do
  use BackEndWeb, :view

  alias BackEnd.{Tools}

  def render("index.json", %{saved_files: saved_files}) do
    ret = %{success: true, data: render_many(saved_files, __MODULE__, "saved_file.json")}
  end

  def render("show.json", %{saved_file: saved_file}) do
    %{success: true, data: render_one(saved_file, __MODULE__, "saved_file.json")}
  end

  def render("saved_file.json", %{saved_file: saved_file}) do
    file = if Tools.assoc_loaded?(saved_file.file),do: render_many(saved_file.file, __MODULE__, "job.json", as: :file)
		%{
			id: saved_file.id
		}
		|> Map.put(:file, file)
  end

	def render("file.json", %{file: file}) do
		%{
			id: file.id
		}
  end
end