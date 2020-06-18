defmodule BackEndWeb.AuthController do
  use BackEndWeb, :controller

  alias BackEnd.Auth.{Account, Accounts}
  alias BackEndWeb.AuthView
  alias BackEnd.{ Tools, Company, Guardian, Repo }

  action_fallback(BackendWeb.FallbackController)

  def auth_account(_conn, %{"accessToken" => token}) do
    if Tools.is_empty?(token) do
      {:failed, :success_false_with_reason, "Bạn chưa có tài khoản"}
    else
      with {:ok, value} <- Guardian.decode_and_verify(token),
           {:ok, account} <- Accounts.get_account(value["id"]) do
        account = AuthView.render("user.json", account)

        {:success, :with_data, account}
      else
        reason ->
          {:failed, :success_false_with_reason, "Error"}
      end
    end
  end

  def sign_in(conn, %{"email" => email, "role" => role, "password" => password}) do
    user = Accounts.get_account_by_email(email, role)

    with {:ok, account} <- Account.check_password(password, user),
         {:ok, token, _} <-
          BackEnd.Guardian.encode_and_sign(
             account,
             %{
               id: account.id,
               email: account.email,
               user_name: account.user_name,
               role: account.role
             },
             week: 4
           ) do
      account = AuthView.render("user.json", account)

      conn
      |> put_status(:ok)
      |> json(%{success: true, account: account, token: token})
    end
  end

  def create(
        _conn,
        %{
          "user_name" => user_name,
          "email" => email,
          "phone_number" => phone_number,
          "password" => password_hash,
          "confirm" => confirm_password,
          "role" => role,
          "company_name" => company_name,
          "personnel_scale" => personnel_scale,
          "company_address" => company_address,
          "province" => province
        } = _params
      ) do
    cond do
      password_hash != confirm_password ->
        {:failed, :success_false_with_reason, "Mật khẩu không khớp"}
      !Tools.validate_email(email) ->
        {:failed, :success_false_with_reason, "Email không hợp lệ"}
      true ->
        user = %{
          user_name: user_name,
          email: email,
          password_hash: password_hash,
          role: role,
          phone_number: phone_number
        }  
        with {:ok, account} <- Accounts.create_account(user),
             {:ok, token, _} <-
               BackEnd.Guardian.encode_and_sign(account, %{
                 id: account.id,
                 email: account.email,
                 user_name: account.user_name,
                 role: account.role
               }) do
            if role == "employer" do 
              company = 
                %{
                  company_name: company_name,
                  personnel_scale: personnel_scale,
                  company_address: company_address,
                  province: province,
                  description: nil,
                  field_of_activity: nil,
                  website: nil,
                  company_phone_number: phone_number,
                  fax: nil,
                  account_id: account.id
                }
              %Company{}
              |> Company.changeset(company)
              |> Repo.insert() 
            end
          account = AuthView.render("user.json", account)

          {:success, :with_data, :data, %{account: account, token: token}}
        else
          {:error, changeset} ->
            message = Tools.get_error_message_from_changeset(changeset)
            {:failed, :success_false_with_reason, message}
        end
    end
  end

  def update(_conn, params) do
    with {:ok, account} <- Accounts.get_account(params["account"]["id"]),
         {:ok, updated_account} <- Accounts.update_account(account, params["account"]) do
      account = AuthView.render("user.json", updated_account)
      {:success, :with_data, :data, %{account: account}}
    end
  end

  def get_user(_conn, params) do
    with {:ok, value} <- Accounts.get_user_by_url(params["account_url"]) do
      value = AuthView.render("user.json", value)
      {:success, :with_data, :user, value}
    else
      {:error, :entity_not_existed} ->
        message = "Account not existed"
        {:failed, :success_false_with_reason, message}
    end
  end
end