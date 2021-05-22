defmodule SigaWeb.RequirementsView do
  use SigaWeb, :view
  alias SigaWeb.RequirementsView

  def render("index.json", %{requirements: requirements}) do
    %{data: render_many(requirements, RequirementsView, "requirements.json")}
  end

  def render("show.json", %{requirements: requirements}) do
    %{data: render_one(requirements, RequirementsView, "requirements.json")}
  end

  def render("requirements.json", %{requirements: requirements}) do
    %{id: requirements.id,
      type: requirements.type}
  end
end
