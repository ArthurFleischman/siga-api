defmodule SigaWeb.Guardian.AuthErrorHandler do
  @behaviour Guardian.Plug.ErrorHandler
  use SigaWeb, :controller
  import Plug.Conn

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    IO.puts("[ERROR LOG] #{to_string(type)}")

    conn
    |> put_status(:unauthorized)
    |> json(%{reason: to_string(reason)})
  end
end
