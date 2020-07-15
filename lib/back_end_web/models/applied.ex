defmodule BackEnd.Applied do
  use Ecto.Schema
  import Ecto.Changeset
  alias BackEnd.Auth.Account
  alias Backend.{JobPost}

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "applied" do
    field :status, :string
    field :note, :string
    
    belongs_to :user, Account, foreign_key: :account_id, type: Ecto.UUID
    belongs_to :job, JobPost, foreign_key: :job_id, type: Ecto.UUID

    timestamps()

    @optional_fields [:status, :note, :account_id, :job_id]
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @optional_fields)
    |> validate_required([:account_id, :job_id, :status],
      message: "Thiếu dữ liệu"
    )
  end
end