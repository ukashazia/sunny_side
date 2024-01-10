defmodule SunnySide.Repo do
  use Ecto.Repo,
    otp_app: :sunny_side,
    adapter: Ecto.Adapters.Postgres
end
