defmodule SigaWeb.UserController do
  use SigaWeb, :controller

  alias Siga.Accounts
  alias Siga.Accounts.User

  action_fallback SigaWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    Accounts.authenticate_cred(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:not_found, reason}, conn) do
    conn
    |> put_status(:not_found)
    |> render("404.json", reason: reason)
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_status(:ok)
    |> render("user.json", user: user)
  end
end
