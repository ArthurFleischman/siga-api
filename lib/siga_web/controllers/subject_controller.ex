defmodule SigaWeb.SubjectController do
  use SigaWeb, :controller

  alias Siga.Entities
  alias Siga.Entities.Subject

  action_fallback SigaWeb.FallbackController

  def index(conn, _params) do
    subjects = Entities.list_subjects()
    render(conn, "index.json", subjects: subjects)
  end

  def create(conn, %{"subject" => subject_params}) do
    with {:ok, %Subject{} = subject} <- Entities.create_subject(subject_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.subject_path(conn, :show, subject))
      |> render("show.json", subject: subject)
    end
  end

  def show(conn, %{"id" => id}) do
    subject = Entities.get_subject!(id)
    render(conn, "show.json", subject: subject)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = Entities.get_subject!(id)

    with {:ok, %Subject{} = subject} <- Entities.update_subject(subject, subject_params) do
      render(conn, "show.json", subject: subject)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = Entities.get_subject!(id)

    with {:ok, %Subject{}} <- Entities.delete_subject(subject) do
      send_resp(conn, :no_content, "")
    end
  end
end
