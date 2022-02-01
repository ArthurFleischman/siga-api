defmodule SigaWeb.SubjectView do
  use SigaWeb, :view
  alias SigaWeb.SubjectView

  def render("index.json", %{subjects: subjects}) do
    %{data: render_many(subjects, SubjectView, "subject.json")}
  end

  def render("show.json", %{subject: subject}) do
    %{data: render_one(subject, SubjectView, "subject.json")}
  end

  def render("subject.json", %{subject: subject}) do
    %{id: subject.id,
      hours: subject.hours,
      name: subject.name}
  end
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
