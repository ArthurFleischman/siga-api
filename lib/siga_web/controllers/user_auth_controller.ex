defmodule SigaWeb.UserAuthController do
  use SigaWeb, :controller
  alias Siga.Entities
  # alias Siga.Accounts.User

  def login(conn, %{"username" => username, "password" => password}) do
    Entities.authenticate_account(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:not_found, reason}, conn) do
    conn
    |> put_status(:not_found)
    |> render("404.json", reason: reason)
  end

  defp login_reply({:ok, user}, conn) do
    with {:ok, token, _claims} <-
           SigaWeb.Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("user.json", %{user: user, token: token})
    end
  end

  def logout(conn, _params) do
    conn
    |> revoke_token()
    |> put_status(:ok)
    |> text("you got signed out")
  end

  defp revoke_token(conn) do
    conn
    |> SigaWeb.Guardian.Plug.current_token()
    |> SigaWeb.Guardian.revoke()

    conn
  end

  def is_session_up(conn, _params) do
    conn
    |> put_status(:ok)
    |> text(to_string(Guardian.Plug.session_active?(conn)))
  end
end
