defmodule SigaWeb.RequirementView do
  use SigaWeb, :view
  alias SigaWeb.RequirementView

  def render("index.json", %{requirement: requirement}) do
    %{data: render_many(requirement, RequirementView, "requirement.json")}
  end

  def render("show.json", %{requirement: requirement}) do
    %{data: render_one(requirement, RequirementView, "requirement.json")}
  end

  def render("requirement.json", %{requirement: requirement}) do
    %{id: requirement.id,
      type: requirement.type}
  end
end
