defmodule BackEnd.Guardian do
  use Guardian, otp_app: :back_end

  alias BackEnd.Auth.Accounts

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = Accounts.get_account_by_id(id)
    IO.inspect(user, label: "aaaa")
    {:ok, user}
  end
end