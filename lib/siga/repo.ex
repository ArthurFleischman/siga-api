defmodule Siga.Repo do
  use Ecto.Repo,
    otp_app: :siga,
    adapter: Ecto.Adapters.Postgres
end
