defmodule SigaWeb.Router do
  use SigaWeb, :router
  use Plug.ErrorHandler

  defimpl Plug.Exception, for: Ecto.NoResultsError do
    @impl true
    def status(_exception), do: :not_found

    @impl true
    def actions(_), do: []
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SigaWeb do
    pipe_through :api
    get "/ping", ServerController, :ping
    get "/uptime/:format", ServerController, :uptime
    post "/login", UserAuthController, :login

    resources "/users", UserController, except: [:new, :edit]
    resources "/requirements", RequirementsController, except: [:new, :edit]
    resources "/subjects", SubjectController, except: [:new, :edit]
  end

  scope "/api/safe", SigaWeb do
    pipe_through SigaWeb.Guardian.AuthPipeline
    # resources "/users", UserController, except: [:new, :edit]
    # resources "/requirements", RequirementsController, except: [:new, :edit]
    # resources "/subjects", SubjectController, except: [:new, :edit]
    post "/logout", UserAuthController, :logout
    get "/check", UserAuthController, :is_session_up
  end
end
