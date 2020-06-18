defmodule BackEnd.Auth.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias BackEnd.Auth.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "accounts" do
    field(:user_name, :string)
    field(:email, :string)
    field(:password_hash, :string)
    field(:role, :string)
		field(:avatar, :string)
		field(:phone_number, :string)

    timestamps()
  end

  def changeset(%Account{} = account, att) do
    account
    |> cast(att, [:user_name, :email, :password_hash, :phone_number, :role])
    |> validate_required([:user_name, :email, :password_hash],
      message: "Không để thiếu username, email hoặc password"
    )
    |> validate_length(:password_hash,
      min: 6,
      message: "Mật khẩu phải lớn hơn 8 kí tự"
    )
    |> unique_constraint(:email,
      name: :accounts_email_index,
      message: "Email đã được đăng kí"
    )
    |> put_password_hash()
  end

  def changeset_update(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:user_name, :email])
    |> unique_constraint(:email,
      name: :accounts_email_index,
      message: "Email đã được đăng kí"
    )
  end

  def put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_hash: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end

  def check_password(_password_hash, nil), do: {:error, "Password hoặc email không đúng"}

  def check_password(password, user) do
    if Bcrypt.verify_pass(password, user.password_hash),
      do: {:ok, user},
      else: {:error, "Password hoặc email không đúng"}
  end
end