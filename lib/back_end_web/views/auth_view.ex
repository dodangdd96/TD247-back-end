defmodule BackEndWeb.AuthView do
  def render("user.json", account) do
    Map.take(account, [
      :user_name,
      :email,
      :id,
      :role
    ])
  end

  def render_many("accounts.json", accounts) do
    Enum.map(accounts, fn u ->
      render("user.json", u)
    end)
  end
end