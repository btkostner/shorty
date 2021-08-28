defmodule Shorty.Repo do
  use Ecto.Repo,
    otp_app: :shorty,
    adapter: Ecto.Adapters.Postgres
end
