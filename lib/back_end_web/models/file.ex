defmodule BackEnd.File do
    use Ecto.Schema
    import Ecto.Changeset
    alias BackEnd.Auth.Account
  
    @primary_key {:id, :binary_id, autogenerate: true}
    schema "files" do
      field :full_name, :string
      field :phone_number, :string
      field :email, :string
      field :date_of_birth, :naive_datetime
      field :address, :string
      field :sex, :string
      field :marital_status, :string
      field :position, :string
      field :years_of_experience, :string
      field :benefit, :string
      field :level, :string
      field :minimum_wage, :string
      field :career_goals, {:array, :string}
      field :academic_level, :string
      field :workplace, :string
      field :type_of_work, :string
      field :salary, :string
      field :maximun_wage, :string
      field :describe_the_goal, :string
      field :training_places, :string
      field :training_department, :string
      field :degree, :string
      field :specialized, :string
      field :classification, :string
      field :time_to_start_learning, :naive_datetime
      field :time_to_end_learning, :naive_datetime
      field :additional_information, :string
      field :comapny_position, :string
      field :comapny, :string
      field :time_to_start_work, :naive_datetime
      field :time_to_end_work, :naive_datetime
      field :current_work, :boolean
      field :work_description, :string
      field :advanced_skill_note, :string
      field :advanced_skill, {:array, :string}
      field :language_skills, {:array, :map}
      field :office_skills, {:array, :map}
      field :career, :string
  
			belongs_to :account, Account, foreign_key: :account_id, type: Ecto.UUID
  
      timestamps()
  
      @optional_fields [:full_name, :phone_number, :email, :date_of_birth, :address,
        :minimum_wage, :position, :years_of_experience, :benefit, :level,
        :degree, :sex, :career_goals, :academic_level, :career,
				:workplace, :type_of_work, :salary, :maximun_wage, :marital_status,
				:describe_the_goal, :training_places, :training_department,
				:specialized, :classification, :time_to_start_learning, :time_to_end_learning,
				:additional_information, :comapny_position, :comapny, :time_to_start_work,
				:time_to_end_work, :current_work, :work_description, :advanced_skill_note,
				:advanced_skill, :language_skills, :office_skills, :account_id
      ]
    end
  
    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, @optional_fields)
      |> validate_required([:full_name, :phone_number, :email],
				message: "Thiếu trường"
		)
    end
  end