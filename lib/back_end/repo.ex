defmodule BackEnd.Repo do
  use Ecto.Repo, 
    otp_app: :back_end,
    adapter: Ecto.Adapters.Postgres
end
