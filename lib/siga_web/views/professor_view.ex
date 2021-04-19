defmodule SysdevWeb.ProfessorView do
  use SigaWeb, :view
  alias SysdevWeb.ProfessorView

  def render("index.json", %{professor: professor}) do
    %{data: render_many(professor, ProfessorView, "professor.json")}
  end

  def render("show.json", %{professor: professor}) do
    %{data: render_one(professor, ProfessorView, "professor.json")}
  end

  def render("professor.json", %{professor: professor}) do
    %{id: professor.id,
      professors: professor.professors,
      name: professor.name,
      email: professor.email,
      password: professor.password}
  end
end
