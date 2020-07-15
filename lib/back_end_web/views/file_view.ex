defmodule BackEndWeb.FileView do
  use BackEndWeb, :view

  def render("index.json", %{files: files}) do
    %{success: true, data: render_many(files, BackEndWeb.FileView, "file.json")}
  end

  def render("show.json", %{file: file}) do
    %{success: true, data: render_one(file, BackEndWeb.FileView, "file.json")}
  end

  def render("file.json", %{file: file}) do
    %{
      id: file.id,
      full_name: file.full_name, 
      phone_number: file.phone_number, 
      email: file.email, 
      date_of_birth: file.date_of_birth, 
      address: file.address,
      minimum_wage: file.minimum_wage, 
      position: file.position, 
      years_of_experience: file.years_of_experience, 
      benefit: file.benefit, 
      level: file.level,
      degree: file.degree, 
      sex: file.sex, 
      career_goals: file.career_goals,
      academic_level: file.academic_level,
      workplace: file.workplace, 
      type_of_work: file.type_of_work,
      salary: file.salary, 
      maximun_wage: file.maximun_wage,
      describe_the_goal: file.describe_the_goal, 
      training_places: file.training_places,
      training_department: file.training_department,
      specialized: file.specialized, 
      classification: file.classification, 
      time_to_start_learning: file.time_to_start_learning,
      time_to_end_learning: file.time_to_end_learning,
      additional_information: file.additional_information,
      comapny_position: file.comapny_position,
      comapny: file.comapny, 
      time_to_start_work: file.time_to_start_work,
      time_to_end_work: file.time_to_end_work,
      current_work: file.current_work, 
      work_description: file.work_description,
      advanced_skill_note: file.advanced_skill_note,
      advanced_skill: file.advanced_skill, 
      language_skills: file.language_skills, 
      office_skills: file.office_skills,
      career: file.career,
      marital_status: file.marital_status,
      updated_at: file.updated_at
    }
  end
  end