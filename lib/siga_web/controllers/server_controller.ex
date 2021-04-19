defmodule SysdevWeb.ServerController do
  use SigaWeb, :controller
  use Agent

  action_fallback SysdevWeb.FallbackController

  def ping(conn,_params)do
    conn
    |> put_resp_content_type("text/plain")
    |> put_status(:ok)
    |> text("pong")
  end

  def uptime(conn,%{"format" => value}) do
    with {status_code,msg} <- Sysdev.BucketServer.uptime(value) do
      conn
      |> put_resp_content_type("text/plain")
      |> put_status(status_code)
      |> text(msg)

    end
  end

end
