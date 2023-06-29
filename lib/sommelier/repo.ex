defmodule Sommelier.Repo do
  use Ecto.Repo,
    otp_app: :sommelier,
    adapter: Ecto.Adapters.Postgres
end
