defmodule SigaWeb.Router do
  use SigaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SigaWeb do
    pipe_through :api
    get "/ping", ServerController, :ping
    get "/uptime/:format", ServerController, :uptime

    resources "/student", StudentController, except: [:new, :edit]

    resources "/professor", ProfessorController, except: [:new, :edit]
  end
end
