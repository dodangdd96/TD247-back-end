defmodule BackEndWeb.JobPostView do
  use BackEndWeb, :view

  def render("index.json", %{job_posts: job_posts}) do
    %{success: true, data: render_many(job_posts, BackEndWeb.JobPostView, "job_post.json")}
  end

  def render("show.json", %{job_post: job_post}) do
    %{success: true, data: render_one(job_post, BackEndWeb.JobPostView, "job_post.json")}
	end

  def render("job_post.json", %{job_post: job_post}) do
    %{
      id: job_post.id,
      position: job_post.position,
      index: job_post.index,
      wage: job_post.wage,
      number_of_recruitment: job_post.number_of_recruitment,
      level: job_post.level,
      type_of_work: job_post.type_of_work,
      province: job_post.province,
      career: job_post.career,
			description: job_post.description,
			benefit: job_post.benefit,
      experience: job_post.experience,
			degree: job_post.degree,
			sex: job_post.sex,
      period: job_post.period,
			language: job_post.language,
			job_requirements: job_post.job_requirements,
			profile_required: job_post.profile_required,
			contact: job_post.contact,
      email_contact: job_post.email_contact,
      phone_number_contact: job_post.phone_number_contact
    }
  end
end