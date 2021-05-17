defmodule SigaWeb.Router do
  use SigaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SigaWeb do
    pipe_through :api
    get "/ping", ServerController, :ping
    get "/uptime/:format", ServerController, :uptime
    post "/login", UserAuthController, :login
  end

  scope "/api/safe", SigaWeb do
    pipe_through SigaWeb.Guardian.AuthPipeline

    resources "/users", UserController, except: [:new, :edit]
    resources "/subjects", SubjectController, except: [:new, :edit]
  end
end
