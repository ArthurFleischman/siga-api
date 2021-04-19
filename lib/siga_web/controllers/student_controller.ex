defmodule SysdevWeb.StudentController do
  use SigaWeb, :controller

  alias Sysdev.User
  alias Sysdev.User.Student

  action_fallback SysdevWeb.FallbackController

  def index(conn, _params) do
    student = User.list_student()
    render(conn, "index.json", student: student)
  end

  def create(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- User.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.student_path(conn, :show, student))
      |> render("show.json", student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = User.get_student!(id)
    render(conn, "show.json", student: student)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = User.get_student!(id)

    with {:ok, %Student{} = student} <- User.update_student(student, student_params) do
      render(conn, "show.json", student: student)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = User.get_student!(id)

    with {:ok, %Student{}} <- User.delete_student(student) do
      send_resp(conn, :no_content, "")
    end
  end
end
