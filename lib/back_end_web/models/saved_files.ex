defmodule BackEnd.SavedFile do
  use Ecto.Schema
  import Ecto.Changeset
	alias BackEnd.Auth.Account
	alias Backend.File

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "saved_files" do
		field :note, :string
		field :is_removed, :boolean
    

    belongs_to :user, Account, foreign_key: :account_id, type: Ecto.UUID
    belongs_to :file, File, foreign_key: :file_id, type: Ecto.UUID

    timestamps()

    @optional_fields [:is_removed, :note, :account_id, :file_id]
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @optional_fields)
    |> validate_required([:account_id, :file_id],
      message: "Thiếu dữ liệu"
    )
  end
end