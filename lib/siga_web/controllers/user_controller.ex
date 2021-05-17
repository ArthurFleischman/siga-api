defmodule SigaWeb.UserController do
  use SigaWeb, :controller
  alias Siga.Entities
  alias Siga.Entities.User

  action_fallback SigaWeb.FallbackController

  def index(conn, _params) do
    users = Entities.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Entities.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Entities.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Entities.get_user!(id)

    with {:ok, %User{} = user} <- Entities.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Entities.get_user!(id)

    with {:ok, %User{}} <- Entities.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
