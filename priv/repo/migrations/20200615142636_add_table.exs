defmodule BackEnd.Repo.Migrations.AddTable do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:user_name, :string, null: false)
      add(:email, :string, null: false)
      add(:password_hash, :string)
      add(:avatar, :string)
      add(:phone_number, :string)
      add(:role, :string)

      timestamps()
    end

    create table(:companys, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:company_name, :string, null: false)
      add(:personnel_scale, :string)
      add(:company_address, :string)
      add(:province, :string)
      add(:description, :text)
      add(:field_of_activity, :text)
      add(:website, :string)
      add(:company_phone_number, :string)
      add(:fax, :string)
      add(:account_id, :uuid)

      timestamps()
    end

    create table(:applied, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:account_id, :uuid, null: false)
      add(:job_id, :uuid, null: false)
      add(:status, :string)
      add(:note, :string)

      timestamps()
    end

    create table(:saved_jobs, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:account_id, :uuid, null: false)
      add(:job_id, :uuid, null: false)
      add(:note, :string)
      add(:is_removed, :boolean)

      timestamps()
    end

    create table(:saved_files, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:account_id, :uuid, null: false)
      add(:file_id, :uuid, null: false)
      add(:note, :string)
      add(:is_removed, :boolean)

      timestamps()
    end
  end
end
