defmodule BackEnd.Repo.Migrations.AddFilesColumn do
  use Ecto.Migration

  def change do
    create table(:files, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:full_name, :string)
      add(:phone_number, :string)
      add(:email, :string)
      add(:date_of_birth, :naive_datetime)
      add(:address, :string)
      add(:sex, :string)
      add(:marital_status, :string)
      add(:position, :string)
      add(:years_of_experience, :string)
      add(:benefit, :string)
      add(:level, :string)
      add(:minimum_wage, :string)
      add(:career_goals, {:array, :string})
      add(:academic_level, :string)
      add(:workplace, :string)
      add(:type_of_work, :string)
      add(:salary, :string)
      add(:maximun_wage, :string)
      add(:describe_the_goal, :string)
      add(:training_places, :string)
      add(:training_department, :string)
      add(:degree, :string)
      add(:specialized, :string)
      add(:classification, :string)
      add(:time_to_start_learning, :naive_datetime)
      add(:time_to_end_learning, :naive_datetime)
      add(:additional_information, :string)
      add(:comapny_position, :string)
      add(:comapny, :string)
      add(:time_to_start_work, :naive_datetime)
      add(:time_to_end_work, :naive_datetime)
      add(:current_work, :boolean)
      add(:work_description, :string)
      add(:advanced_skill_note, :string)
      add(:advanced_skill, {:array, :string})
      add(:language_skills, {:array, :map})
      add(:office_skills, {:array, :map})
      add(:account_id, :uuid)

      timestamps()
    end
  end
end