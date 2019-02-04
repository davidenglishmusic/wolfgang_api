defmodule WolfgangApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      WolfgangApi.Repo,
      # Start the endpoint when the application starts
      WolfgangApiWeb.Endpoint
      # Starts a worker by calling: WolfgangApi.Worker.start_link(arg)
      # {WolfgangApi.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WolfgangApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    WolfgangApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
