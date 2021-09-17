defmodule SigaWeb.Guardian.AuthErrorHandler do
  @behaviour Guardian.Plug.ErrorHandler
  use SigaWeb, :controller
  import Plug.Conn

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> put_status(:bad_request)
    |> json(%{message: to_string(type), reason: to_string(reason)})
  end
end
