defmodule BackEndWeb.Plug.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias BackEnd.Auth.Accounts
  alias BackEnd.Guardian

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    token =
      conn
      |> get_req_header("authorization")
      |> List.first()
      |> String.slice((String.length("Bearer") + 1)..-1)

    with {:ok, value} <- Guardian.decode_and_verify(token),
         {:ok, account} <- Accounts.get_account(value["id"]) do
      conn
      |> assign(:account, account)
    else
      reason ->
        IO.inspect(reason, label: "aaaaaaaa")

        conn
        |> put_status(:unauthorized)
        |> json(%{success: false, message: "Authentication failed! Account not found!"})
        |> halt()
    end
  end
end