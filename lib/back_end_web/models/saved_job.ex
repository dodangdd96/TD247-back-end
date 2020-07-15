defmodule BackEnd.SavedJob do
  use Ecto.Schema
  import Ecto.Changeset
	alias Backend.JobPost

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "saved_jobs" do
		field :note, :string
		field :is_removed, :boolean
    
    belongs_to :user, BackEnd.Auth.Account, foreign_key: :account_id, type: Ecto.UUID
    belongs_to :job, JobPost, foreign_key: :job_id, type: Ecto.UUID

    timestamps()

    @optional_fields [:is_removed, :note, :account_id, :job_id]
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @optional_fields)
    |> validate_required([:account_id, :job_id],
      message: "Thiếu dữ liệu"
    )
  end
end