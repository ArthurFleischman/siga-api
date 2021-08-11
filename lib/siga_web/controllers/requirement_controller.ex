defmodule SigaWeb.RequirementController do
  use SigaWeb, :controller

  alias Siga.Subjects
  alias Siga.Subjects.Requirement

  action_fallback SigaWeb.FallbackController

  def index(conn, _params) do
    requirement = Subjects.list_requirement()
    render(conn, "index.json", requirement: requirement)
  end

  def create(conn, %{"requirement" => requirement_params}) do
    with {:ok, %Requirement{} = requirement} <- Subjects.create_requirement(requirement_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.requirement_path(conn, :show, requirement))
      |> render("show.json", requirement: requirement)
    end
  end

  def show(conn, %{"id" => id}) do
    requirement = Subjects.get_requirement!(id)
    render(conn, "show.json", requirement: requirement)
  end

  def update(conn, %{"id" => id, "requirement" => requirement_params}) do
    requirement = Subjects.get_requirement!(id)

    with {:ok, %Requirement{} = requirement} <-
           Subjects.update_requirement(requirement, requirement_params) do
      render(conn, "show.json", requirement: requirement)
    end
  end

  def delete(conn, %{"id" => id}) do
    requirement = Subjects.get_requirement!(id)

    with {:ok, %Requirement{}} <- Subjects.delete_requirement(requirement) do
      send_resp(conn, :no_content, "")
    end
  end
end
