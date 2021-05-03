defmodule SigaWeb.StudentView do
  use SigaWeb, :view
  alias SigaWeb.StudentView

  def render("index.json", %{student: student}) do
    %{data: render_many(student, StudentView, "student.json")}
  end

  def render("show.json", %{student: student}) do
    %{data: render_one(student, StudentView, "student.json")}
  end

  def render("student.json", %{student: student}) do
    %{id: student.id,
      students: student.students,
      name: student.name,
      email: student.email,
      password: student.password}
  end
end
