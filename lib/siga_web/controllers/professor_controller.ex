defmodule SysdevWeb.ProfessorController do
  use SigaWeb, :controller

  alias Sysdev.User
  alias Sysdev.User.Professor

  action_fallback SysdevWeb.FallbackController

  def index(conn, _params) do
    professor = User.list_professor()
    render(conn, "index.json", professor: professor)
  end

  def create(conn, %{"professor" => professor_params}) do
    with {:ok, %Professor{} = professor} <- User.create_professor(professor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.professor_path(conn, :show, professor))
      |> render("show.json", professor: professor)
    end
  end

  def show(conn, %{"id" => id}) do
    professor = User.get_professor!(id)
    render(conn, "show.json", professor: professor)
  end

  def update(conn, %{"id" => id, "professor" => professor_params}) do
    professor = User.get_professor!(id)

    with {:ok, %Professor{} = professor} <- User.update_professor(professor, professor_params) do
      render(conn, "show.json", professor: professor)
    end
  end

  def delete(conn, %{"id" => id}) do
    professor = User.get_professor!(id)

    with {:ok, %Professor{}} <- User.delete_professor(professor) do
      send_resp(conn, :no_content, "")
    end
  end
end
