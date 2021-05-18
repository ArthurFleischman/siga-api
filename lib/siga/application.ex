defmodule Siga.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application, Timex

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Siga.Repo,
      # Start the Telemetry supervisor
      SigaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Siga.PubSub},
      # Start the Endpoint (http/https)
      SigaWeb.Endpoint,
      {Guardian.DB.Token.SweeperServer, []},
      # Start a worker by calling: Siga.Worker.start_link(arg)
      # {Siga.Worker, arg}
      {Siga.BucketServer, %{"init_time" => get_date_time()}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Siga.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_date_time() do
    Timex.now(Application.get_env(:siga, :timezone) || "America/Recife")
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SigaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
