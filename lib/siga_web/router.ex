defmodule SigaWeb.Router do
  use SigaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SigaWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]

    get "/ping", ServerController, :ping
    get "/uptime/:format", ServerController, :uptime
  end
end
