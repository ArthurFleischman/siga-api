defmodule SigaWeb.Router do
  use SigaWeb, :router
  use Plug.ErrorHandler

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SigaWeb do
    pipe_through :api
    get "/ping", ServerController, :ping
    get "/uptime/:format", ServerController, :uptime
    post "/login", UserAuthController, :login

    scope "/api/safe" do
      pipe_through SigaWeb.Guardian.AuthPipeline
      resources "/users", UserController, except: [:new, :edit]
      resources "/requirements", RequirementController, except: [:new, :edit]
      resources "/subjects", SubjectController, except: [:new, :edit]
      post "/logout", UserAuthController, :logout
      get "/check", UserAuthController, :is_session_up
    end
  end
end
