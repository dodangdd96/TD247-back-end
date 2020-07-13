defmodule BackEnd.Repo.Migrations.AddJobPostTable do
  use Ecto.Migration

  def change do
    create table(:job_posts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:position, :string)
      add(:index, :string)
      add(:wage, :string)
      add(:number_of_recruitment, :integer)
      add(:level, :string)
      add(:type_of_work, :string)
      add(:province, :string)
      add(:career, :string)
      add(:description, :text)
      add(:benefit, :text)
      add(:experience, :string)
      add(:degree, :string)
      add(:sex, :string)
      add(:period, :naive_datetime)
      add(:language, :string)
      add(:job_requirements, :text)
      add(:profile_required, :text)
      add(:contact, :string)
      add(:email_contact, :string)
      add(:phone_number_contact, :string)
      add(:account_id, :uuid)
      add(:is_posted, :boolean)

      timestamps()
    end
  end
end
