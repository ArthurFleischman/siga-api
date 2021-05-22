defmodule SigaWeb.RequirementsController do
  use SigaWeb, :controller

  alias Siga.Entities
  alias Siga.Entities.Requirements

  action_fallback SigaWeb.FallbackController

  def index(conn, _params) do
    requirements = Entities.list_requirements()
    render(conn, "index.json", requirements: requirements)
  end

  def create(conn, %{"requirements" => requirements_params}) do
    with {:ok, %Requirements{} = requirements} <- Entities.create_requirements(requirements_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.requirements_path(conn, :show, requirements))
      |> render("show.json", requirements: requirements)
    end
  end

  def show(conn, %{"id" => id}) do
    requirements = Entities.get_requirements!(id)
    render(conn, "show.json", requirements: requirements)
  end

  def update(conn, %{"id" => id, "requirements" => requirements_params}) do
    requirements = Entities.get_requirements!(id)

    with {:ok, %Requirements{} = requirements} <- Entities.update_requirements(requirements, requirements_params) do
      render(conn, "show.json", requirements: requirements)
    end
  end

  def delete(conn, %{"id" => id}) do
    requirements = Entities.get_requirements!(id)

    with {:ok, %Requirements{}} <- Entities.delete_requirements(requirements) do
      send_resp(conn, :no_content, "")
    end
  end
end
