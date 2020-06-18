defmodule BackEnd.JobPost do
  use Ecto.Schema
  import Ecto.Changeset
  alias BackEnd.Company

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "job_posts" do
    field :position, :string
    field :index, :string
    field :wage, :string
    field :number_of_recruitment, :integer
    field :level, :string
    field :type_of_work, :string
    field :province, :string
    field :career, :string
    field :description, :string
    field :benefit, :string
    field :experience, :string
    field :degree, :string
    field :sex, :string
    field :period, :naive_datetime
    field :language, :string
    field :job_requirements, :string
    field :profile_required, :string
    field :contact, :string
    field :email_contact, :string
    field :phone_number_contact, :string

    belongs_to :company, Company, foreign_key: :company_id, type: Ecto.UUID

    timestamps()

    @optional_fields [:position, :wage, :number_of_recruitment, :level, :type_of_work,
      :province, :career, :description, :benefit, :experience,
      :degree, :sex, :period, :language, :job_requirements,
      :profile_required, :contact, :email_contact, :phone_number_contact,
    ]
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @optional_fields)
    |> validate_required([:position, :wage, :number_of_recruitment, :level],
      message: "Thiếu trường"
    )
  end
end