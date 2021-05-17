defmodule SigaWeb.UserAuthController do
  use SigaWeb, :controller
  alias Siga.Accounts
  # alias Siga.Accounts.User

  def login(conn, %{"username" => username, "password" => password}) do
    Accounts.authenticate_account(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:not_found, reason}, conn) do
    conn
    |> put_status(:not_found)
    |> render("404.json", reason: reason)
  end

  defp login_reply({:ok, user}, conn) do
    with {:ok, jwt, _claims} <- SigaWeb.Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("user.json", %{user: user, token: jwt})
    end
  end

  def authorize(conn, _params) do
    if Guardian.Plug.authenticated?(conn) do
      user = Guardian.Plug.current_resource(conn)
      {user, conn}
    else
      IO.puts("no user")
      {:ok, conn}
    end
  end
end
