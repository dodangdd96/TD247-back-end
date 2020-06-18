defmodule BackEnd.Company do
    use Ecto.Schema
		import Ecto.Changeset
		alias BackEnd.Auth.Account
  
    @primary_key {:id, :binary_id, autogenerate: true}
    schema "companys" do
      field :company_name, :string
      field :personnel_scale, :string
      field :company_address, :string
      field :province, :string
      field :description, :string
      field :field_of_activity, :string
      field :website, :string
      field :company_phone_number, :string
			field :fax, :string

			belongs_to :account, Account, foreign_key: :account_id, type: Ecto.UUID
  
      timestamps()
    end
  
    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:company_name, :account_id, :personnel_scale, :company_address, :province, :description, :field_of_activity, :company_phone_number, :website, :fax])
      |> validate_required([:company_name, :personnel_scale, :company_address, :province],
        message: "Không để thiếu tên, địa chỉ hoặc khu vực"
      )
    end
  end